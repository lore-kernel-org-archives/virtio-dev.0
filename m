Return-Path: <virtio-comment-return-3554-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <25d0b0bc-6680-9e13-9be6-9eed7b78d0d1@redhat.com>
Date: Fri, 25 Nov 2022 11:24:18 +0800
MIME-Version: 1.0
References: <20221123210706.21476-1-mst@redhat.com>
 <20221123210706.21476-4-mst@redhat.com>
 <CACGkMEsezk_O=pWh0MzLBdVnmSrWjqzsbrPYgwvztPKyPiKrtg@mail.gmail.com>
 <20221124020857-mutt-send-email-mst@kernel.org>
 <CACGkMEuUYmx9MO6Yui+6orLU99FAS6kgNqf9Gcv_nNoGtJL5nQ@mail.gmail.com>
 <20221124025909-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221124025909-mutt-send-email-mst@kernel.org>
Subject: [virtio-comment] Re: [PATCH v9 03/10] admin: introduce group administration commands
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2022/11/24 16:03, Michael S. Tsirkin =E5=86=99=E9=81=93:
> On Thu, Nov 24, 2022 at 03:42:18PM +0800, Jason Wang wrote:
>> On Thu, Nov 24, 2022 at 3:12 PM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
>>> On Thu, Nov 24, 2022 at 01:52:41PM +0800, Jason Wang wrote:
>>>> On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
>>>>> This introduces a general structure for group administration commands=
,
>>>>> used to control device groups through their owner.
>>>>>
>>>>> Following patches will introduce specific commands and an interface f=
or
>>>>> submitting these commands to the owner.
>>>>>
>>>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>> ---
>>>>>   admin.tex | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++
>>>>>   1 file changed, 98 insertions(+)
>>>>>
>>>>> diff --git a/admin.tex b/admin.tex
>>>>> index 6ebdd05..1dca136 100644
>>>>> --- a/admin.tex
>>>>> +++ b/admin.tex
>>>>> @@ -42,4 +42,102 @@ \section{Device groups}\label{sec:Basic Facilitie=
s of a Virtio Device / Device g
>>>>>   PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over =
PCI Bus}).
>>>>>   \end{description}
>>>>>
>>>>> +\subsection{Group administration commands}\label{sec:Basic Facilitie=
s of a Virtio Device / Device groups / Group administration commands}
>>>>>
>>>>> +Group administration commands can be issued through an owner
>>>>> +device to control member devices of a group.  This mechanism can
>>>>> +be used, for example, to configure a member device before it is
>>>>> +initialized by its driver.
>>>> This excludes any possible runtime configuration, is this intended?
>>> No idea - what kind of runtime configuration are you talking about?
>>> This explicitly says "to configure a member device" and that's
>>> certainly at runtime.
>> Not sure, but if we say something like we, it means we need a group of
>> commands to support runtime stuff in the future?
> we'll need commands to provision members - is this what you
> mean? for sure.


Yes.


>
>>>
>>>>> +
>>>>> +All the group administration commands are of the following form:
>>>>> +
>>>>> +\begin{lstlisting}
>>>>> +struct virtio_admin_cmd {
>>>>> +        /* Device-readable part */
>>>>> +        le16 opcode;
>>>>> +        /*
>>>>> +         * 1 - SR-IOV
>>>>> +         * 2 - 65535 reserved
>>>>> +         */
>>>>> +        le16 group_type;
>>>>> +        /* unused, reserved for future extensions */
>>>>> +        u8 reserved1[12];
>>>>> +        le64 group_member_id;
>>>>> +        u8 command_specific_data[];
>>>>> +
>>>>> +        /* Device-writable part */
>>>>> +        le16 status;
>>>>> +        le16 status_qualifier;
>>>>> +        /* unused, reserved for future extensions */
>>>>> +        u8 reserved2[4];
>>>>> +        u8 command_specific_result[];
>>>>> +};
>>>>> +\end{lstlisting}
>>>>> +
>>>>> +For all commands, \field{opcode}, \field{group_type} and if
>>>>> +necessary \field{group_member_id} and \field{command_specific_data} =
are
>>>>> +set by the driver, and the owner device sets \field{status} and if
>>>>> +needed \field{status_qualifier} and
>>>>> +\field{command_specific_result}.
>>>>> +
>>>>> +As a rule, any unused device-readable fields are set to zero by the =
driver
>>>>> +and ignored by the device.  Any unused device-writeable fields are s=
et to zero
>>>>> +by the device and ignored by the driver.
>>>>> +
>>>>> +\field{opcode} specifies the command. The valid
>>>>> +values for \field{opcode} can be found in the following table:
>>>>> +
>>>>> +\begin{tabular}{|l|l|}
>>>>> +\hline
>>>>> +opcode & Name & Command Description \\
>>>>> +\hline \hline
>>>>> +0x0000 - 0x7FFF & - &  Group administration commands    \\
>>>>> +\hline
>>>>> +0x8000 - 0xFFFF & - & Reserved    \\
>>>>> +\hline
>>>>> +\end{tabular}
>>>>> +
>>>>> +The \field{group_type} specifies the group type identifier.
>>>> So this means there's no way for having a group specific adminq? E.g
>>>> one queue for SR-IOV and another for SIOV.
>>>>
>>>>> +The \field{group_member_id} specifies the member identifier within t=
he group.
>>>>> +See section \ref{sec:Introduction / Terminology / Device group}
>>>>> +for the definition of the group type identifier and group member
>>>>> +identifier.
>>>>> +
>>>>> +The following table describes possible \field{status} values;
>>>>> +to simplify common implementations, they are intentionally
>>>>> +matching common Linux names and error numbers:
>>>> I may miss something but I don't see how it matches Linux error number=
s.
>>>
>>> include/uapi/asm-generic/errno-base.h:#define   EINVAL          22     =
 /* Invalid argument */
>> Ok, only this one was matched but any advantages of menting the
>> matching? I believe not all the error numbers are meaningful for a
>> device interface (e.g EINTR).
>>
>> Thanks
> Makes it easier for driver to decide on an error to
> report to userspace. If we don't use all error codes
> that's fine.


Ok.

Thanks


>
>
>
>
>>>
>>>> Thanks
>>>>
>>>>> +
>>>>> +\begin{tabular}{|l|l|l|}
>>>>> +\hline
>>>>> +Status (decimal) & Name & Description \\
>>>>> +\hline \hline
>>>>> +00   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
>>>>> +\hline
>>>>> +22   & VIRTIO_ADMIN_STATUS_EINVAL    & invalid command \\
>>>>> +\hline
>>>>> +other   & -    & group administration command error  \\
>>>>> +\hline
>>>>> +\end{tabular}
>>>>> +
>>>>> +When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qialifi=
er}
>>>>> +is reserved and set to zero by the device.
>>>>> +
>>>>> +When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL,
>>>>> +the following table describes possible \field{status_qialifier} valu=
es:
>>>>> +\begin{tabular}{|l|l|l|}
>>>>> +\hline
>>>>> +Status & Name & Description \\
>>>>> +\hline \hline
>>>>> +0x00   & VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND   & command error: no=
 additional information  \\
>>>>> +\hline
>>>>> +0x01   & VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE    & unsupported or in=
valid \field{opcode}  \\
>>>>> +\hline
>>>>> +0x02   & VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD    & unsupported or inv=
alid field within \field{command_specific_data}  \\
>>>>> +\hline
>>>>> +0x03   & VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP    & unsupported or inv=
alid \field{group_type} \\
>>>>> +\hline
>>>>> +0x04   & VIRTIO_ADMIN_STATUS_Q_INVALID_MEM    & unsupported or inval=
id \field{group_member_id} \\
>>>>> +\hline
>>>>> +0x05-0xFFFF   & -    & reserved for future use \\
>>>>> +\hline
>>>>> +\end{tabular}
>>>>> --
>>>>> MST
>>>>>


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

