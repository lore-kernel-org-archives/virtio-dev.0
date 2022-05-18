Return-Path: <virtio-comment-return-3051-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <e6446d40-9144-b615-b7ea-e807600b6aab@nvidia.com>
Date: Wed, 18 May 2022 16:39:54 +0300
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-3-mgurtovoy@nvidia.com>
 <20220515111056-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220515111056-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v5 2/7] Introduce admin command set
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 5/15/2022 6:23 PM, Michael S. Tsirkin wrote:
> On Wed, Apr 27, 2022 at 01:58:19AM +0300, Max Gurtovoy wrote:
>> This command set is used for essential administrative and management
>> operations.
>>
>> Admin commands should be submitted to a well defined management
>> interface.
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   admin.tex   | 123 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   content.tex |   2 +
>>   2 files changed, 125 insertions(+)
>>   create mode 100644 admin.tex
>>
>> diff --git a/admin.tex b/admin.tex
>> new file mode 100644
>> index 0000000..6725daa
>> --- /dev/null
>> +++ b/admin.tex
>> @@ -0,0 +1,123 @@
>> +\section{Administration command set}\label{sec:Basic Facilities of a Virtio Device / Administration command set}
>> +
>> +The Administration command set (also known as Admin command set) defines the commands that can be issued using a management interface.
>> +This mechanism, for example, can be used by a system administrator that wants to configure a device before it is initialized by its driver.
>> +
>> +All the Admin commands are of the following form:
>> +
>> +\begin{lstlisting}
>> +struct virtio_admin_cmd {
>> +        /* Device-readable part */
>> +        le16 command;
>> +        /*
>> +         * 0 - self
>> +         * 1 - 65535 are reserved
>> +         */
>> +        le16 dst_type;
>> +        /* reserved for common cmd fields */
>> +        u8 reserved[20];
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
>> +\end{tabular}
>> +
>> +The \field{command}, \field{dst_type} and \field{command_specific_data} are
>> +set by the driver, and the device sets the \field{status}, the
>> +\field{command_specific_error} and the \field{command_specific_result},
>> +if needed.
>> +
>> +Reserved common fields are ignored by the device and to be zeroed by the driver.
>> +
>> +The mandatory fields to be set by the driver, for all admin commands, are \field{command} and \field{dst_type}.
>> +
>> +The \field{command} defines the opcode for the command. The value for each command can be found in each command section.
>> +
>> +The \field{dst_type} defines the designated virtio device for the command. This value should be set to 0 (self).
>> +
>> +The \field{command_specific_error} should be inspected by the driver only if \field{status} is set to
>> +VIRTIO_ADMIN_STATUS_CS_ERR by the device. In this case, the content of \field{command_specific_error}
>> +holds the command specific error. If \field{status} is not set to VIRTIO_ADMIN_STATUS_CS_ERR, the
>> +\field{command_specific_error} value is undefined and should be ignored by the driver.
>> +
>> +The following table describes the Admin command set:
>> +
>> +\begin{tabular}{|l|l|l|}
>> +\hline
>> +Opcode & Command & M/O \\
>> +\hline \hline
>> +0000h   & VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY    & M  \\
>> +\hline
>> +0001h   & VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT    & M  \\
>> +\hline
>> +0002h - 7FFFh   & Generic admin cmds    & -  \\
>> +\hline
>> +8000h - FFFFh   & Reserved    & - \\
>> +\hline
>> +\end{tabular}
>> +
>> +\subsection{VIRTIO ADMIN DEVICE CAPS IDENTIFY command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE CAPS IDENTIFY command}
> why without _ here?

The pdf generator doesn't like _

If someone will fix it, I'll add _

>
>> +
>> +The VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY command has no command specific data set by the driver.
>> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_CAPS_IDENTIFY by the driver.
>> +
>> +The device, upon success, returns a result that describes information about the designated virtio device.
> result really just means a result structure right? let's say so.

"The device, upon success, returns a result structure that describes 
information about the designated virtio device."

is the above ok ?

MST, Jason and Cornelia please ack.

>> +This result is of form:
>> +\begin{lstlisting}
>> +struct virtio_admin_device_caps_identify_result {
>> +       /* Indicates which of the below fields were returned
>> +        * (1 means that field was returned):
> what does this mean "field is returned"? above restult is returned.

It means: if bit i is 1, then the value/values described by bit i are valid.

Is this ok ?

>> +        * Bit 0 - device_admin_caps
>> +        * Bits 1 - 63 - reserved for future fields
>> +        */
>> +       le64 attrs_mask;
>> +       /* This field indicates which of the below admin
>> +        * capabilities are supported by the device:
>> +        * Bits 0 - 63 - reserved for future capabilities.
>> +        */
>> +       le64 device_admin_caps;
>
> so all of the field is reserved?

the bellow 112 bytes are reserved.

the result is 128B and for this stage 112B are reserved for future 
extensions.

I minimized it from 4k to 128B.

Please ack.

>
>> +       u8 reserved[112];
>> +};
>> +\end{lstlisting}
>> +
>> +\subsection{VIRTIO ADMIN DEVICE CAPS ACCEPT command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE CAPS ACCEPT command}
>> +
>> +The VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT command is used by the driver to acknowledge those admin capabilities it understands and wishes to use.
>
> ok so we have a protocol here, kind of like feature negotiation. Please write its description.
> e.g. is it ok to change accepted caps? when? can device change its caps
> etc etc etc.

I don't understand what does this mean to change a cap ?

Device can offer a cap and driver can accept it if it wishes to use it.

That is it.

I added this mechanism just for your request.

I never saw a device that asks acceptance from driver but I did my best 
to fulfill your request.

>
> Avoiding this kind of spec work is exactly why me and jason keep telling
> you to consider just using features instead. Add a 64 bit admin features
> field to the PCI transport and be done with it. CCW and MMIO already
> have feature selector so it's trivial to add feature bits.

It's not scalable for admin mechanism and I don't want to perform 100 
write/read from configuration space instead of doing all in 1 admin command.

>
>
>> +The \field{command} is set to VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT by the driver.
>> +
>> +The command specific data set by the driver is of form:
>> +\begin{lstlisting}
>> +struct virtio_admin_device_caps_accept_data {
>> +       /* Indicates which of the below fields were set
>> +        * (1 means that field is set):
>
> yes we all know that 1 means set.
>
> do you really mean field is valid maybe?
yes valid == set.
>
>
>> +        * Bit 0 - driver_admin_caps
>> +        * Bits 1 - 63 - reserved for future fields
>> +        */
>> +       le64 attrs_mask;
> looks like going overboard. just send 64 caps bits and be done with it.
> and rename accept_data to accept_caps.
this is the command specific data.
>
>> +       /* This field indicates which of the below admin
>> +        * capabilities are supported by the driver:
>> +        * Bits 0 - 63 - reserved for future capabilities.
>> +        */
>> +       le64 driver_admin_caps;
>> +       u8 reserved[112];
>
> I just noticed this. Please do not add this huge amount of padding
> everywhere. instead, explain that device must be ready to accept
> a smaller or larger buffer depending on feature bits.

It's not huge. It's 128B command data.

We will be sorry in the future for not doing extendable API.

I prefer keep it 128B unless there is a concrete reason for not doing so.

>
>> +};
>> +\end{lstlisting}
>> diff --git a/content.tex b/content.tex
>> index c6f116c..2e1df84 100644
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

