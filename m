Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH v10 04/10] admin: introduce virtio admin virtqueues
Date: Sat, 11 Feb 2023 18:50:57 +0000
Message-ID: <PH0PR12MB5481E9C5C0ACA3E8182004BCDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-5-mst@redhat.com>
In-Reply-To: <20230209121221.15118-5-mst@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>
Cc: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, February 9, 2023 7:14 AM
> +
> +If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
An owner device supports one or more..

> +or more adminstration virtqueues. The number and locations of the
> +administration virtqueues are exposed by the owner device in a
> +transport specific manner.
> +
> +The driver submits commands by queueing them to an arbitrary
Do you prefer 'driver adds commands' instead of two verbs of 'submitting' a=
nd 'queueuing', like we discussed in other thread for enqueuing/post vs add=
?

I prefer the driver enqueues command and device process them in order.

> +administration virtqueue, and they are processed by the device in the
> +order in which they are queued. It is the responsibility of the driver
> +to ensure ordering for commands placed on different administration
ordering of commands reads better than ordering for commands to me.

> +virtqueues, because they will be executed with no order constraints.
> +
> +Administration virtqueues are used as follows:
Does it have to be plural to describe an operation?

> +\begin{itemize}
> +\item The driver submits the command using the \field{struct
> +virtio_admin_cmd} structure using a buffer consisting of two parts: a
> +device-readable one followed by a device-writable one.
> +\item the device-readable part includes fields from \field{opcode}
> +through \field{command_specific_data}.
> +\item the device-writeable buffer includes fields from \field{status}
> +through \field{command_specific_result} inclusive.
> +\end{itemize}
> +
> +For each command, this specification describes a distinct format
> +structure used for \field{command_specific_data} and
> +\field{command_specific_result}, the length of these fields depends on
> +the command.
> +
> +However, to ensure forward compatibility \begin{itemize} \item drivers
> +are allowed to submit buffers that are longer than what the device
> +expects (that is, longer than the length of \field{opcode} through
> +\field{command_specific_data}).
> +This allows the driver to maintain
> +a single format structure even if some structure fields are unused by
> +the device.
> +\item drivers are allowed to submit buffers that are shorter than what
> +the device expects (that is, shorter than the length of \field{status}
> +through \field{command_specific_result}). This allows the device to
> +maintain a single format structure even if some structure fields are
> +unused by the driver.
> +\end{itemize}
> +
> +The device compares the length of each part (device-readable and
> +device-writeable) of the buffer as submitted by driver to what it
> +expects and then silently truncates the structures to either the length
> +submitted by the driver, or the length described in this specification,
> +whichever is shorter.  The device silently ignores any data falling
> +outside the shorter of the two lengths. Any missing fields are
> +interpreted as set to zero.
> +
> +Similarly, the driver compares the used buffer length of the buffer to
> +what it expects and then silently truncates the structure to the used
> +buffer length.
> +The driver silently ignores any data falling outside the used buffer
> +length reported by the device.  Any missing fields are interpreted as
> +set to zero.
Above buffer size description is very well written.
I don't remember this in earlier version. May be was there.
Thanks.

