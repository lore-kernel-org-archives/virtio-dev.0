Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <af4f4530-406f-cc30-748f-94ee916a6b8a@nvidia.com>
Date: Mon, 13 Feb 2023 02:54:47 +0200
Subject: Re: [PATCH v10 03/10] admin: introduce group administration commands
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-4-mst@redhat.com>
 <PH0PR12MB54817D14FBFDD561D8BCDF7EDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230212044245-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230212044245-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 12/02/2023 11:49, Michael S. Tsirkin wrote:
> On Sat, Feb 11, 2023 at 06:50:37PM +0000, Parav Pandit wrote:
>>
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Thursday, February 9, 2023 7:14 AM
>>
>> [..]
>>
>>> +Group administration commands can be issued through an owner device to
>>> +control member devices of a group.
>> can be issued by the owner device to control ...
> 
> Well it's clearly the driver that issues the commands. Don't see how
> can a device issue them. If instead of "through an owner device"
> you prefer a more verbose "the driver of an owner device" then
> I can live with that. Let me know.
> 
>>> This mechanism can be used, for
>>> +example, to configure a member device before it is initialized by its
>>> +driver.
>>> +\footnote{The term "administration" is intended to be interpreted
>>> +widely to include any kind of control. See specific commands for
>>> +detail.}
>>> +
>>> +All the group administration commands are of the following form:
>>> +
>>> +\begin{lstlisting}
>>> +struct virtio_admin_cmd {
>>> +        /* Device-readable part */
>>> +        le16 opcode;
>>> +        /*
>>> +         * 1 - SR-IOV
>>> +         * 2 - 65535 reserved
>>> +         */
>>> +        le16 group_type;
>>> +        /* unused, reserved for future extensions */
>>> +        u8 reserved1[12];
>>> +        le64 group_member_id;
>>> +        u8 command_specific_data[];
>>> +
>>> +        /* Device-writable part */
>>> +        le16 status;
>>> +        le16 status_qualifier;
>>> +        /* unused, reserved for future extensions */
>>> +        u8 reserved2[4];
>>> +        u8 command_specific_result[];
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +For all commands, \field{opcode}, \field{group_type} and if necessary
>>> +\field{group_member_id} and \field{command_specific_data} are set by
>>> +the driver, and the owner device sets \field{status} and if needed
>>> +\field{status_qualifier} and \field{command_specific_result}.
>>> +
>>> +As a rule, any unused device-readable fields are set to zero by the
>>> +driver and ignored by the device.  Any unused device-writeable fields
>>> +are set to zero by the device and ignored by the driver.
>>> +
>> General spec structure is describing the "rules" as device and driver side requirements.
>> Can you please move above rule paragraph belongs to device and driver requirements section?
> 
> Generally we have a bit of duplication. A high level description
> showing how things work together. Then per-device/driver conforumance
> statements. So I think this should stay but I will look at adding
> conformance clauses too.
> 
>>> +\field{opcode} specifies the command. The valid values for
>>> +\field{opcode} can be found in the following table:
>>> +
>>> +\begin{tabular}{|l|l|}
>>> +\hline
>>> +opcode & Name & Command Description \\
>>> +\hline \hline
>>> +0x0000 - 0x7FFF & - &  Group administration commands    \\
>>> +\hline
>>> +0x8000 - 0xFFFF & - & Reserved    \\
>>> +\hline
>>> +\end{tabular}
>>> +
>>> +The \field{group_type} specifies the group type identifier.
>>> +The \field{group_member_id} specifies the member identifier within the
>>> group.
>>> +See section \ref{sec:Introduction / Terminology / Device group} for the
>>> +definition of the group type identifier and group member identifier.
>>> +
>>> +The following table describes possible \field{status} values; to
>>> +simplify common implementations, they are intentionally matching common
>>> +Linux names and error numbers:
>>> +
>> I am not sure it should be intentional and mention of Linux.
>> Any OS would need multiple error values to know the error cause.
>> Linux doesn't have name "OK" either for well-known value of 0.
>>
>> For example
>> $ errno 22
>> EINVAL 22 Invalid argument
>>
>> $ errno 0
>> This has not output for it and doesn't exist in errno.h.
> 
> No name OK true, but it does use 0 to signal success sometimes:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fman7.org%2Flinux%2Fman-pages%2Fman3%2Ferrno.3.html&data=05%7C01%7Cmgurtovoy%40nvidia.com%7Cbe231a7ec67b432a259d08db0cde7e10%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C638117921964323355%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=4pRK48Hlc%2BTaMAOd8dx1B0jjNf7gvkqJ8SSCMhZVv0o%3D&reserved=0
> 
> For some system calls and library functions (e.g.,
>         getpriority(2)), -1 is a valid return on success.  In such cases,
>         a successful return can be distinguished from an error return by
>         setting errno to zero before the call, and then, if the call
>         returns a status that indicates that an error may have occurred,
>         checking to see if errno has a nonzero value.
> 
> 
> 
>> Description is already good enough to describe what they are.
>> Can we please drop Linux wording?
> 
> But why should we? It's where 22 comes from so this way people are not
> wondering about the value, and it's somewhat helpful for Linux
> developers.
> 

I also think we should not mention Linux. I don't think it's mentioned 
currently in the spec and no good reason to do so now.
Also value of 22 is not mandatory for this EINVAL status code. It can be 
just 1 (the first number after the OK status).
Developers should be able to read the specification and find out the 
meaning of error code.

> 
>>> +\begin{tabular}{|l|l|l|}
>>> +\hline
>>> +Status (decimal) & Name & Description \\ \hline \hline
>>> +00   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
>>> +\hline
>>> +22   & VIRTIO_ADMIN_STATUS_EINVAL    & invalid command \\
>>> +\hline
>>> +other   & -    & group administration command error  \\
>>> +\hline
>>> +\end{tabular}
>>> +
>>> +When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qialifier}
>> s/status_qialifier/status_qualifier
>>
>>> +is reserved and set to zero by the device.
>>> +
>>> +When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL, the following table
>>> +describes possible \field{status_qialifier} values:
>> s/status_qialifier/status_qualifier
> 
> 
> Thanks!
> 

