from ansible.plugins.callback import CallbackBase

class CallbackModule(CallbackBase):

    def on_any(self, *args, **kwargs):
        if 'playbook' in kwargs:
            playbook = kwargs['playbook']
            tasks_to_hide = ["Checking if the user exists"]

            for host, host_vars in playbook.get_variable_manager().get_vars().items():
                if 'playbook' in host_vars:
                    tasks = host_vars['playbook']['tasks']
                    for task in tasks:
                        if task.get('name', '') in tasks_to_hide:
                            task['_ansible_verbose_always'] = False

    def on_task_start(self, task, is_conditional):
        if not task.get_variable('ansible_verbose_always', True):
            # If the task should not be shown, we override the stream and set it to /dev/null
            task.action.set_stream('start_line', task.action._get_task_tmp_path())
