Return-Path: <virtio-dev-return-10266-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 687D39864E9
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 Nov 2022 12:21:18 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <CACGkMEsezk_O=pWh0MzLBdVnmSrWjqzsbrPYgwvztPKyPiKrtg@mail.gmail.com>
References: <20221123210706.21476-1-mst@redhat.com>
 <20221123210706.21476-4-mst@redhat.com>
 <CACGkMEsezk_O=pWh0MzLBdVnmSrWjqzsbrPYgwvztPKyPiKrtg@mail.gmail.com>
Date: Thu, 24 Nov 2022 13:21:10 +0100
Message-ID: <87edtsh7bd.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v9 03/10] admin: introduce group
 administration commands
Content-Type: text/plain
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 24 2022, Jason Wang <jasowang@redhat.com> wrote:

> On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>> +All the group administration commands are of the following form:
>> +
>> +\begin{lstlisting}
>> +struct virtio_admin_cmd {
>> +        /* Device-readable part */
>> +        le16 opcode;
>> +        /*
>> +         * 1 - SR-IOV
>> +         * 2 - 65535 reserved
>> +         */
>> +        le16 group_type;
>> +        /* unused, reserved for future extensions */
>> +        u8 reserved1[12];
>> +        le64 group_member_id;
>> +        u8 command_specific_data[];
>> +
>> +        /* Device-writable part */
>> +        le16 status;
>> +        le16 status_qualifier;
>> +        /* unused, reserved for future extensions */
>> +        u8 reserved2[4];
>> +        u8 command_specific_result[];
>> +};
>> +\end{lstlisting}
>> +
>> +For all commands, \field{opcode}, \field{group_type} and if
>> +necessary \field{group_member_id} and \field{command_specific_data} are
>> +set by the driver, and the owner device sets \field{status} and if
>> +needed \field{status_qualifier} and
>> +\field{command_specific_result}.
>> +
>> +As a rule, any unused device-readable fields are set to zero by the driver
>> +and ignored by the device.  Any unused device-writeable fields are set to zero
>> +by the device and ignored by the driver.
>> +
>> +\field{opcode} specifies the command. The valid
>> +values for \field{opcode} can be found in the following table:
>> +
>> +\begin{tabular}{|l|l|}
>> +\hline
>> +opcode & Name & Command Description \\
>> +\hline \hline
>> +0x0000 - 0x7FFF & - &  Group administration commands    \\
>> +\hline
>> +0x8000 - 0xFFFF & - & Reserved    \\
>> +\hline
>> +\end{tabular}
>> +
>> +The \field{group_type} specifies the group type identifier.
>
> So this means there's no way for having a group specific adminq? E.g
> one queue for SR-IOV and another for SIOV.

I don't see anything that prevents the device from exposing two admin
queues... do you mean that we should provide a mechanism for the device
to mandate that only commands for a certain group id can go on a certain
admin queue?

>
>> +The \field{group_member_id} specifies the member identifier within the group.
>> +See section \ref{sec:Introduction / Terminology / Device group}
>> +for the definition of the group type identifier and group member
>> +identifier.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

