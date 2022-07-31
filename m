Return-Path: <virtio-comment-return-3268-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <f4ae9bf0-6f99-19f7-4e44-39519122ff66@nvidia.com>
Date: Mon, 1 Aug 2022 02:56:42 +0300
References: <20220731154354.15698-1-mgurtovoy@nvidia.com>
 <20220731154354.15698-3-mgurtovoy@nvidia.com>
 <20220731163847-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220731163847-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v6 2/5] Introduce admin command set
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org, eperezma@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 7/31/2022 11:59 PM, Michael S. Tsirkin wrote:
> On Sun, Jul 31, 2022 at 06:43:51PM +0300, Max Gurtovoy wrote:
>> This command set is used for essential administrative and management
>> operations.
>>
>> Admin commands should be submitted to a well defined management
>> interface.
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Looks good. Minor comments.
>
>> ---
>>   admin.tex   | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   content.tex |  2 ++
>>   2 files changed, 84 insertions(+)
>>   create mode 100644 admin.tex
>>
>> diff --git a/admin.tex b/admin.tex
>> new file mode 100644
>> index 0000000..d14f8f7
>> --- /dev/null
>> +++ b/admin.tex
>> @@ -0,0 +1,82 @@
>> +\section{Administration command set}\label{sec:Basic Facilities of a Virtio Device / Administration command set}
>> +
>> +The Administration command set (also known as Admin command set) defines the commands that can be issued using a management interface.
> this is the only place where we talk about a management interface
>
> A better definition maybe:
>
> commands that can be used to control one device in a group through
> another device in a group?

I think we already agreed on that wording. We must start adding 
"reviewed-by" stamps.

The above sentence is not true. The goal of this command set is not only 
"control one device in a group through another device in a group".

You can simply see it in this series: definition of the self type device 
group and MGMT_ATTR command.

>
>
>> +This mechanism, for example, can be used by a system administrator that wants to configure a device before it is initialized by its driver.
> Let's just avoid mentioning system administrator here since that's easy
> to confuse with admin commands.
>
> 	For example, this mechanism can be used to configure a device before it is initialized by its driver.

ok. will do.


>
>
>> +All the Admin commands are of the following form:
>> +
>> +\begin{lstlisting}
>> +struct virtio_admin_cmd {
>> +        /* Device-readable part */
>> +        le16 command;
>> +        /*
>> +         * 0 - Self
>> +         * 1 - SR-IOV
>> +         * 2 - 65535 are reserved
>> +         */
>> +        le16 group_id;
> we need 32 bits of padding to align the next field naturally.
> Stick them where you see fit. 16 after command and 16 here?

I think i'll take the entire reserved[12] array above the group_member_id.

ok?

>
>> +        le64 group_member_id;
>> +        /* reserved for common cmd fields */
>> +        u8 reserved[12];
>> +        u8 command_specific_data[];
>> +
>> +        /* Device-writable part */
>> +        u8 status;
>> +        u8 command_specific_error;
>> +        u8 command_specific_result[];
>> +};
>> +\end{lstlisting}
>> +
>> +The following table describes the generic Admin status codes:
>> +
>> +\begin{tabular}{|l|l|l|}
>> +\hline
>> +Opcode & Status & Description \\
>> +\hline \hline
>> +00h   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
>> +\hline
>> +01h   & VIRTIO_ADMIN_STATUS_CS_ERR    & command specific error  \\
>> +\hline
>> +02h   & VIRTIO_ADMIN_STATUS_COMMAND_UNSUPPORTED    & unsupported or invalid opcode  \\
>> +\hline
>> +03h   & VIRTIO_ADMIN_STATUS_INVALID_FIELD    & invalid field was set  \\
>> +\hline
>> +04h   & VIRTIO_ADMIN_STATUS_INVALID_GROUP    & invalid group identifier was set  \\
>> +\hline
>> +05h   & VIRTIO_ADMIN_STATUS_INVALID_MEM    & invalid group member identifier was set  \\
>> +\hline
>> +\end{tabular}
>> +
>> +The \field{command}, \field{group_id}, \field{group_member_id} and \field{command_specific_data} are
>> +set by the driver, and the device sets the \field{status}, the
>> +\field{command_specific_error} and the \field{command_specific_result},
>> +if needed.
>> +
>> +Reserved common fields are ignored by the device and to be zeroed by the driver.
> Add this to conformance statement maybe.

like this ?

+\devicenormative{\subsection}{Administration command set}{Basic 
Facilities of a Virtio Device / Administration command set}
+A device MUST ignore reserved fields for all Administration commands 
arriving to it.
+
+\drivernormative{\subsection}{Administration command set}{Basic 
Facilities of a Virtio Device / Administration command set}
+A driver SHOULD zero reserved fields for all Administration commands 
sending to a device.


>
>> +
>> +The mandatory fields to be set by the driver, for all admin commands, are the \field{command}, \field{group_id} and \field{group_member_id}.
>> +
>> +The optional unused fields to be zeroed by the driver.
> A bit confusing - these are the only fields I see. Is this still
> relevant?

I'll remove.


>
>> +The \field{command} defines the opcode for the command. The value for each command can be found in each command section.
>> +
>> +The \field{group_id} defines the designated device group for the command.
>> +The \field{group_member_id} defines the designated device within the device group for the command.
>> +See section \ref{sec:Introduction / Terminology / Device group} for group identifier and group member identifier numbering for various device groups.
>> +
>
> Hmm not I think it's not precise.
>
> the command is sent by driver to specific a device.
>
> this device (should we come up with a name for it? maybe
This device is referred as designated device. I can call it differently 
if needed.
> the administrative device?) together with the group type id is what defines the device
> group. For example, for the SRIOV type the commands must be
> sent to the PF and refer to the group including the PF
> through which the commands are sent and its VFs.
The device that the command is sent through is the owner of the 
interface. There is no way to be confused here.
>
> For each group that supports specific commands, there is
> one or more devices through which the commands can be given?
>
The owner of the management interface is the mgmt device.


>
>> +The \field{command_specific_error} should be inspected by the driver only if \field{status} is set to
>> +VIRTIO_ADMIN_STATUS_CS_ERR by the device. In this case, the content of \field{command_specific_error}
>> +holds the command specific error. If \field{status} is not set to VIRTIO_ADMIN_STATUS_CS_ERR, the
>> +\field{command_specific_error} value is undefined and should be ignored by the driver.
>> +
>> +The following table describes the Admin command set:
>> +
>> +\begin{tabular}{|l|l|}
>> +\hline
>> +Opcode & Command \\
>> +\hline \hline
>> +0000h - 7FFFh   & Generic admin cmds    \\
>> +\hline
>> +8000h - FFFFh   & Reserved    \\
>> +\hline
>> +\end{tabular}
>> diff --git a/content.tex b/content.tex
>> index 7508dd1..caab298 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -449,6 +449,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>>   types. It is RECOMMENDED that devices generate version 4
>>   UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>>   
>> +\input{admin.tex}
>> +
>>   \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>>   
>>   We start with an overview of device initialization, then expand on the
>> -- 
>> 2.21.0

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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

