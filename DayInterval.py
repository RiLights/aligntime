"""
(lldb) command script import ~/DayInterval.py
(lldb) type summary add AlignTime.DayInterval --python-function DayInterval.SummaryProvider
(lldb) v intervals
"""
def SummaryProvider(valobj,_):
    """valobj: an SBValue which you want to provide a summary for
        internal_dict: an LLDB support object not to be used"""
    id = int(valobj.GetChildMemberWithName('id').GetValue ())
    time = valobj.GetChildMemberWithName('time_string').GetSummary()
    wear = valobj.GetChildMemberWithName('wear').GetSummary().capitalize()
    wear_str = 'wear'
    if wear == 'False':
    	wear_str = 'off'
    return "DayInterval({},{},{})".format(time,wear_str,id)