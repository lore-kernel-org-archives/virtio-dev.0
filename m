Return-Path: <jasowang@redhat.com>
Message-ID: <03aeef39-74bb-d816-47e2-d0bb412c29e3@redhat.com>
Date: Mon, 28 Nov 2022 12:34:43 +0800
MIME-Version: 1.0
Subject: Re: [virtio-comment] Re: [PATCH v9 08/10] admin: command list
 discovery
References: <20221123210706.21476-1-mst@redhat.com>
 <20221123210706.21476-9-mst@redhat.com>
 <CACGkMEsientWq6sKcuB-0hL0uaPJB4dcp4=8c2BXpNRZrd5RWA@mail.gmail.com>
 <20221124032505-mutt-send-email-mst@kernel.org>
 <9d5d131a-abc4-eb15-734c-6092d23014d1@redhat.com>
 <20221125064210-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221125064210-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2022/11/25 19:43, Michael S. Tsirkin 写道:
> On Fri, Nov 25, 2022 at 11:38:30AM +0800, Jason Wang wrote:
>> 在 2022/11/24 16:30, Michael S. Tsirkin 写道:
>>> On Thu, Nov 24, 2022 at 02:40:15PM +0800, Jason Wang wrote:
>>>> On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>> Add commands to find out which commands does each group support,
>>>>> as well as enable their use by driver.
>>>>> This will be especially useful once we have multiple group types.
>>>>>
>>>>> An alternative is per-type VQs. This is possible but will
>>>>> require more per-transport work. Discovery through the vq
>>>>> helps keep things contained.
>>>> This seems to complicate the migration (compatibility) of the adminq
>>>> itself. We need check both features and command list.
>>> Yes. There's no way around this though - commands need to
>>> be per group and a pci device can host at least both
>>> SIOV and SRIOV children.
>>>
>>>
>>>> More below.
>>>>
>>>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> ---
>>>>>    admin.tex | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>>>    1 file changed, 81 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/admin.tex b/admin.tex
>>>>> index eeccd2e..eec12a9 100644
>>>>> --- a/admin.tex
>>>>> +++ b/admin.tex
>>>>> @@ -91,7 +91,9 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>>>>>    \hline
>>>>>    opcode & Name & Command Description \\
>>>>>    \hline \hline
>>>>> -0x0000 - 0x7FFF & - &  Group administration commands    \\
>>>>> +0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
>>>>> +0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands used for this group type \\
>>>>> +0x0002 - 0x7FFF & - &  Group administration commands    \\
>>>>>    \hline
>>>>>    0x8000 - 0xFFFF & - & Reserved    \\
>>>>>    \hline
>>>>> @@ -142,6 +144,84 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>>>>>    \hline
>>>>>    \end{tabular}
>>>>>
>>>>> +Before sending any administration commands to the device, the driver
>>>>> +needs to communicate to the device which commands it is going to
>>>>> +use. Initially (after reset), only two commands are assumed to be used:
>>>>> +VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
>>>>> +
>>>>> +Before sending any other commands for any member of a specific group to
>>>>> +the device, the driver queries the supported commands via
>>>>> +VIRTIO_ADMIN_CMD_LIST_QUERY and sends the commands it will use via
>>>>> +VIRTIO_ADMIN_CMD_LIST_USE.
>>>>> +
>>>>> +Commands VIRTIO_ADMIN_CMD_LIST_QUERY and
>>>>> +VIRTIO_ADMIN_CMD_LIST_USE
>>>>> +both use the following structure describing the
>>>>> +command opcodes:
>>>>> +
>>>>> +\begin{lstlisting}
>>>>> +struct virtio_admin_cmd_list {
>>>>> +       /* Indicates which of the below fields were returned
>>>>> +       le32 device_admin_cmds[];
>>>>> +};
>>>>> +\end{lstlisting}
>>>>> +
>>>>> +This structure is an array of 32 bit values in little-endian byte
>>>>> +order, in which a bit is set if the specific command opcode
>>>>> +is supported.
>>>> Is this simpler if we map group type instead of a single opcode? E.g
>>>> virtqueue transport will introduce 10+ commands, using a bit for a
>>>> specific opcode will complicate things.
>>> I think more flexibility is better, and bits are cheap.
>>
>> So we may end up with something like:
>>
>> If VIRTIO_F_TRANSPORT_VQ is supported, device MUST return the following
>> opcodes via VIRTIO_ADMIN_CMD_LIST_QUERY
>>
>> [opX, opY, ....]
>>
>> Probably fine.
>>
> I think I would tie the commands to a group type.


Right, that's what I understood, but it looks to me it can't be achieved 
via LIST_QUERY now (which is based on opcodes).

Thanks


>
>>>
>>>>> +Thus, \field{device_admin_cmds[0]} refers to the first 32-bit value
>>>>> +in this array corresponding to opcodes 0 to 31,
>>>>> +\field{device_admin_cmds[1]} is the second 32-bit value
>>>>> +corresponding to opcodes 32 to 63, etc.
>>>>> +For example, the array of size 2 including
>>>>> +the values 0x3 in \field{device_admin_cmds[0]}
>>>>> +and 0x1 in \field{device_admin_cmds[1]} indicates that only opcodes 0, 1 and 32
>>>>> +are supported.
>>>>> +
>>>>> +Accordingly, bits 0 and 1 corresponding to opcode 0
>>>>> +(VIRTIO_ADMIN_CMD_LIST_QUERY) and 1
>>>>> +(VIRTIO_ADMIN_CMD_LIST_USE) are
>>>>> +always set in \field{device_admin_cmds[0]} returned by VIRTIO_ADMIN_CMD_LIST_QUERY.
>>>>> +
>>>>> +For the command VIRTIO_ADMIN_CMD_LIST_QUERY, \field{opcode} is set to 0x0.
>>>>> +The \field{group_member_id} is unused. It is set to zero by driver.
>>>>> +This command has no command specific data.
>>>>> +The device, upon success, returns a result in
>>>>> +\field{command_specific_result} in the format
>>>>> +\field{struct virtio_admin_cmd_list} describing the
>>>>> +list of administration commands supported for the given group.
>>>>> +
>>>>> +
>>>>> +For the command VIRTIO_ADMIN_CMD_LIST_USE, \field{opcode}
>>>>> +is set to 0x1.
>>>>> +The \field{group_member_id} is unused. It is set to zero by driver.
>>>>> +The \field{command_specific_data} is in the format
>>>>> +\field{struct virtio_admin_cmd_list} describing the
>>>>> +list of administration commands used by the driver.
>>>>> +This command has no command specific result.
>>>>> +
>>>>> +The driver issues the command VIRTIO_ADMIN_CMD_LIST_QUERY to
>>>>> +query the list of commands valid for this group and before sending
>>>>> +any commands for any member of a group.
>>>>> +
>>>>> +The driver then enables use of some of the opcodes by sending to
>>>>> +the device the command VIRTIO_ADMIN_CMD_LIST_USE with a subset
>>>>> +of the list returned by VIRTIO_ADMIN_CMD_LIST_QUERY that is
>>>>> +both understood and used by the driver.
>>>> Any reason we need to invent a negotiation process here? (This seems
>>>> only useful when some commands/opcodes are mutually exclusive)
>>>>
>>>> Thanks
>>> yes, features don't help because they are per owner.
>>> this is per group.
>>>
>>> imagine vq transport. SET_FEATURES commands sets the features
>>> for the child. we need something to negotiate with owner
>>> but still within the vq.
>>
>> Should we document what happens if driver use a opcode that it doesn't
>> negotiate? (It looks to me we don't document this for at leave virtio-net
>> control virtqueue).
>>
>> Thanks
>>
> documented in the conformance section.
>
>
>>>
>>>>> +
>>>>> +If the device supports the command list used by the driver, the
>>>>> +device completes the command with status VIRTIO_ADMIN_STATUS_OK.
>>>>> +If the device does not support the command list, the device
>>>>> +completes the command with status
>>>>> +VIRTIO_ADMIN_STATUS_INVALID_FIELD.
>>>>> +
>>>>> +Note: drivers are assumed not to set bits in device_admin_cmds
>>>>> +if they are not familiar with how the command opcode
>>>>> +is used, since devices could have dependencies between
>>>>> +command opcodes.
>>>>> +
>>>>> +It is assumed that all members in a group support and are used
>>>>> +with the same list of commands.
>>>>> +
>>>>>    \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
>>>>>
>>>>>    An administration virtqueue of an owner device is used to submit
>>>>> --
>>>>> MST
>>>>>
>>> This publicly archived list offers a means to provide input to the
>>> OASIS Virtual I/O Device (VIRTIO) TC.
>>>
>>> In order to verify user consent to the Feedback License terms and
>>> to minimize spam in the list archive, subscription is required
>>> before posting.
>>>
>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>>> List help: virtio-comment-help@lists.oasis-open.org
>>> List archive: https://lists.oasis-open.org/archives/virtio-comment/
>>> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>>> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>>> Committee: https://www.oasis-open.org/committees/virtio/
>>> Join OASIS: https://www.oasis-open.org/join/
>>>

