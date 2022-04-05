Return-Path: <virtio-comment-return-2901-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <ccd295bf-80c3-10a4-5cb2-7609c6e770d9@nvidia.com>
Date: Tue, 5 Apr 2022 13:58:11 +0300
References: <20220302155608.24189-1-mgurtovoy@nvidia.com>
 <20220302155608.24189-3-mgurtovoy@nvidia.com>
 <20220404080607-mutt-send-email-mst@kernel.org>
 <19121fd6-2bf5-eb60-d8bc-e930e0b0ae65@nvidia.com>
 <20220404121723-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220404121723-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v1 2/5] Introduce Admin Command Set
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 4/4/2022 7:26 PM, Michael S. Tsirkin wrote:
> On Mon, Apr 04, 2022 at 06:35:16PM +0300, Max Gurtovoy wrote:
>> On 4/4/2022 3:50 PM, Michael S. Tsirkin wrote:
>>> On Wed, Mar 02, 2022 at 05:56:05PM +0200, Max Gurtovoy wrote:
>>>> This command set is used for essential administrative and management
>>>> operations such as identify and resource management.
>>>>
>>>> Admin commands should be submitted to a well defined management
>>>> interface.
>>>>
>>>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>>>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>> ---
>>>>    admin.tex        | 129 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>    content.tex      |   2 +
>>>>    introduction.tex |   2 +
>>>>    3 files changed, 133 insertions(+)
>>>>    create mode 100644 admin.tex
>>>>
>>>> diff --git a/admin.tex b/admin.tex
>>>> new file mode 100644
>>>> index 0000000..1e30e01
>>>> --- /dev/null
>>>> +++ b/admin.tex
>>>> @@ -0,0 +1,129 @@
>>>> +\section{Admin command set}\label{sec:Basic Facilities of a Virtio Device / Admin command set}
>>>> +
>>>> +The Admin command set defines the commands that can be issued to a well defined management
>>>> +interface.
>>> This is shorthand for what? Administration commands?
>>> Let's eschew abbreviation pls.
>>> Also, management is a bit oblique, and only the reader can judge how well it's defined :)
>>>
>>>
>>> I would rephrase this along the lines of
>>>
>>> " For security and ease of management reasons, devices can expose an additional interface
>> Why should we add security here ?
>>
>> Lets keep it simple.
> you want some motivation, this has consistently been a problem with this
> project, motivation is not well documented. I say add all that can be
> remotely relevant in here.  The security refers to IOMMU using VF# for
> protection, I think it's relevant.

The spec should be simple and generic. IOMMU/VFs/Security is not related 
to the introduction of the admin command set.

Otherwise, it will grow for each example/reason we'll think in the future.

Also the interface is not relevant and was previously asked to be 
separate from the admin command set patch.

The motivation is clear but we can improve.

We can do:

"The Admin command set defines the commands that can be issued using a dedicated management interface.
  For example, a host management system might want to access and configure a device before it is initialized by
  the device driver. This can be done using a management device and its management driver."

>
>>>     to access the device besides the ones specified in the
>>>     transports section. For example, a host management system
>>>     might want to access the device while in use by driver,
>>>     or to configure the device before it is initialized by
>>>     the driver.
>>>     This access is facilitated through a set of administration commands.
>>>
>>> "
>>>
>>>
>>> speaking of this, are we still going to use the "driver"
>>> terminology for uses of this?
>> There is no other way to access a device from the host/guess other than
>> driver.
>>
>> A management system will have some interface provided by a driver to access
>> a device.
>
> Heh. However with admin commands a driver of device X accesses device Y.
> It is not *the driver* - it's a different driver.

see above. I called it device driver.

> Given we are already getting confused, it looks like we need to differentiate
> between the two types of driver by using some other term here.
> I suggest "administrator" but "manager" or "management driver" could be
> other options. I wonder what do others think.
see above.
>
>>>
>>>> All the Admin commands are of the following form:
>>>> +
>>>> +\begin{lstlisting}
>>>> +struct virtio_admin_cmd {
>>>> +        /* Device-readable part */
>>>> +        le16 command;
>>>> +        /*
>>>> +         * 0 - self
>>>> +         * 1 - 65535 are reserved
>>>> +         */
>>>> +        le16 dst_type;
>>> I think we want to add the vdev id here in the generic command
>>> and just have a special id that means "self".
>> vdev id was added in later patch. No need for special id means self. Each
>> device has only 1 id and not 2.
>>
>> This was proposed by Cornelia IIRC.
> Yea, it's ok with that patch. The way it's split isn't ideal
> unfortunately maybe move it into this patch in the next version.

I'll check if this make sense during the preparations of the next version.


>
>>>
>>>> +        /* reserved for common cmd fields */
>>>> +        u8 reserved[20];
>>>> +        u8 command_specific_data[];
>>>> +
>>>> +        /* Device-writable part */
>>>> +        u8 status;
>>>> +        u8 command_specific_error;
>>>> +        u8 command_specific_result[];
>>>> +};
>>>> +\end{lstlisting}
>>>> +
>>>> +The following table describes the generic Admin status codes:
>>>> +
>>>> +\begin{tabular}{|l|l|l|}
>>>> +\hline
>>>> +Opcode & Status & Description \\
>>>> +\hline \hline
>>>> +00h   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
>>>> +\hline
>>>> +01h   & VIRTIO_ADMIN_STATUS_CS_ERR    & command specific error  \\
>>>> +\hline
>>>> +02h   & VIRTIO_ADMIN_STATUS_COMMAND_UNSUPPORTED    & unsupported or invalid opcode  \\
>>>> +\hline
>>>> +03h   & VIRTIO_ADMIN_STATUS_INVALID_FIELD    & invalid field was set  \\
>>>> +\hline
>>>> +\end{tabular}
>>>> +
>>>> +The \field{command}, \field{dst_type} and \field{command_specific_data} are
>>>> +set by the driver, and the device sets the \field{status}, the
>>>> +\field{command_specific_error} and the \field{command_specific_result},
>>>> +if needed.
>>>> +
>>>> +Reserved common fields are ignored by the device and to be zeroed by the driver.
>>>> +
>>>> +The mandatory fields to be set by the driver, for all admin commands, are \field{command} and \field{dst_type}.
>>>> +
>>>> +The \field{command} defines the opcode for the command. The value for each command can be found in each command section.
>>>> +
>>>> +The \field{dst_type} defines the target virtio device for the command. This value should be set to 0 (self).
>>>> +
>>>> +The \field{command_specific_error} should be inspected by the driver only if \field{status} is set to
>>>> +VIRTIO_ADMIN_STATUS_CS_ERR by the device. In this case, the content of \field{command_specific_error}
>>>> +holds the command specific error. If \field{status} is not set to VIRTIO_ADMIN_STATUS_CS_ERR, the
>>>> +\field{command_specific_error} value is undefined.
>>>> +
>>>> +The following table describes the Admin command set:
>>>> +
>>>> +\begin{tabular}{|l|l|l|}
>>>> +\hline
>>>> +Opcode & Command & M/O \\
>>>> +\hline \hline
>>>> +0000h   & VIRTIO_ADMIN_DEVICE_IDENTIFY    & M  \\
>>>> +\hline
>>>> +0001h   & VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY    & O  \\
>>>> +\hline
>>>> +0002h - 7FFFh   & Generic admin cmds    & -  \\
>>>> +\hline
>>>> +8000h - FFFFh   & Reserved    & - \\
>>>> +\hline
>>>> +\end{tabular}
>>>> +
>>>> +\subsection{VIRTIO ADMIN DEVICE IDENTIFY command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE IDENTIFY command}
>>>> +
>>>> +The VIRTIO_ADMIN_DEVICE_IDENTIFY command has no command specific data set by the driver.
>>>> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_IDENTIFY.
>>>> +Other common fields are reserved for this command and zeroed.
>>>> +
>>>> +This command upon success, returns a data buffer
>>> let's avoid using buffer since we want to allow non-DMA uses
>>> IIUC. just "result" is ok, right?
>> How would device write data to host memory ?
>>
>> driver prepare a buffer and device will write to this buffer.
> commands could use MMIO with no DMA.

what do you mean ?

Are you referring to the suggestion for configuration registers we 
already rejected (please read the cover letter) or something else ?

>
>>>> that describes information about the target virtio device.
>>> target being what? destination?
>> yes.
> then make all wording consistent please.
sure.
>
>>>> +This returned data buffer is of form:
>>>> +\begin{lstlisting}
>>>> +struct virtio_admin_device_identify_result {
>>>> +       /* For compatibility - indicates which of the below fields were returned
>>> compatibility with what?
>> I will remove "compatibility". It just indicates the valid fields.
>>>> +        * (1 means that field was returned):
>>>> +        * Bit 0 - vdev_id
>>>> +        * Bit 1 - optional_caps_support
>>>> +        * Bits 2 - 63 - reserved for future fields
>>>> +        */
>>>> +       le64 attrs_mask;
>>> this seems to be some kind of thing listing supported commands, except
>>> it's one way as opposed to negotiated like feature bits.  From
>>> experience this kind of one way capability might be problematic since
>>> you never know what will be used.  How about just using feature bits
>>> instead? How many of these do you expect to be there?
>> It's not features.
>>
>> I don't see a need for negotiation here.
> I guess I do ;) Donnu what do others think.

The device shouldn't care if a driver "accepts" the fact it support a 
specific command.

The driver can just issue this command.

There is no optimization that should be done if some command is 
supported by the driver (from the device perspective).

>
>
>>> If not, please add a description of this.
>>> E.g. along the lines of
>>>
>>> 	Field \field{attrs_mask} contains a bitmask of valid ?? as defined in ??
>> I described bit by bit and mentioned that this is a mask. For each bit the
>> value of 1 is valid.
>
> Look at e.g. RSS as a better example of documenting this.
>
>>>
>>>> +       le64 vdev_id;
>>> So this is a way to query the id of device itself? Since the only dst
>>> type is self ...
>> For example yes. This is one of the things you can get from this command.
> I don't see why this is useful.

It helps identifying a device inside a virtio subsystem/group.

>
>>>
>>>> +       /* This field indicates which of the below optional admin
>>>> +        * capabilities are supported by the device:
>>>> +        * Bit 0 - if set, VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY supported
>>>> +        * Bits 1 - 63 - reserved for future capabilities.
>>>> +        */
>>>> +       le64 optional_caps_support;
>>>> +       u8 reserved[4072];
>>> What exactly is this reserved thing? Does this mean the structure is
>>> always exactly 4k?
>> Yes the result buffer size is 4k.
>>
> That's huge, will be a problem if it's MMIO and not DMA, and
> mostly just wasted. why not make it as big as it needs to be?

But in another place you've asked why it is so small.

You need it to be fixed size since the format is the contract between 
the driver and the device.

We don't want to start negotiating on each bit.

>
>>>> +};
>>>> +\end{lstlisting}
>>>> +
>>>> +\subsection{VIRTIO ADMIN SUBSYSTEM IDENTIFY command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN SUBSYSTEM IDENTIFY command}
>>>> +
>>>> +The VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY command has no command specific data set by the driver.
>>>> +The \field{command} is set to VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY.
>>>> +Other common fields are reserved for this command and zeroed.
>>> zeroed by driver?
>> Yes.
> you want to go over places like this and everywhere say who does what.

if it's clear I can remove it.

>
>>>> +
>>>> +This command upon success, returns a data buffer that describes information about the target virtio device subsystem.
>>>> +This returned data buffer is of form:
>>>> +\begin{lstlisting}
>>>> +struct virtio_admin_subsystem_identify_result {
>>>> +       /* For compatibility - indicates which of the below fields were returned
>>>> +        * (1 means that field was returned):
>>>> +        * Bit 0 - vqn
>>>> +        * Bit 1 - num_supported_vdevs
>>>> +        * Bit 2 - max_vdev_id
>>>> +        * Bits 3 - 63 - reserved for future fields
>>>> +        */
>>>> +       le64 attrs_mask;
>>> add description here.
>> Ok.
>>
>>>> +       u8 vqn[16];
>>>> +       /* Number of supported virtio devices by the subsystem */
>>>> +       le64 num_supported_vdevs;
>>>> +       /* Maximum value of a valid vdev_id for the subsystem */
>>>> +       le64 max_vdev_id;
>>>> +       u8 reserved[4056];
>>>> +};
>>>> +\end{lstlisting}
>>>> diff --git a/content.tex b/content.tex
>>>> index c6f116c..2e1df84 100644
>>>> --- a/content.tex
>>>> +++ b/content.tex
>>>> @@ -449,6 +449,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>>>>    types. It is RECOMMENDED that devices generate version 4
>>>>    UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>>>> +\input{admin.tex}
>>>> +
>>>>    \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
>>>>    We start with an overview of device initialization, then expand on the
>>>> diff --git a/introduction.tex b/introduction.tex
>>>> index 8e6611e..94dd7a2 100644
>>>> --- a/introduction.tex
>>>> +++ b/introduction.tex
>>>> @@ -258,5 +258,7 @@ \subsection{virtio subsystem}\label{sec:Introduction / Definitions / virtio subs
>>>>    The vdev_id value when combined with the VQN forms a globally unique value that identifies the virtio device.
>>>> +VQN and vdev_id are exposed via Admin Command Set.
>>>> +
>>>>    \newpage
>>>> -- 
>>>> 2.21.0

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

