Return-Path: <virtio-comment-return-3488-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221121012419.317406-5-mst@redhat.com>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-5-mst@redhat.com>
Date: Tue, 22 Nov 2022 14:14:23 +0100
Message-ID: <8735abf7ww.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v8 4/9] admin: introduce virtio admin virtqueues
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Nov 20 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> The admin virtqueues will be the first interface to issue admin commands.
>
> Currently virtio specification defines control virtqueue to manipulate
> features and configuration of the device it operates on. However,
> control virtqueue commands are device type specific, which makes it very
> difficult to extend for device agnostic commands.
>
> To support this requirement in a more generic way, this patch introduces
> a new admin virtqueue interface.
>
> We also support more than one admin virtqueue, for QoS and
> scalability requirements.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  admin.tex   | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  content.tex |  6 ++++--
>  2 files changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/admin.tex b/admin.tex
> index 507e188..bfa63a2 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -128,3 +128,56 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>  other   & -    & group administration command error  \\
>  \hline
>  \end{tabular}
> +
> +\section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
> +
> +An administration virtqueue of an owner device is used to submit
> +group administration commands. An owner device can have more
> +than one administration virtqueue.
> +
> +Administration virtqueues exists for a certain owner device if
> +VIRTIO_F_ADMIN_VQ feature has been negotiated. The index of the
> +first administration virtqueue and their number is exposed by the
> +owner device in a transport specific manner.

(Do we always expect admin virtqueues to use a range of indices, i.e. no
holes? That seems a bit limiting.)

What about

"If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
or more adminstration virtqueues. The number and locations of the
administration virtqueues is exposed by the owner device in a transport
specific manner."

> +
> +The driver submits commands by queueing them to an arbitrary
> +administration virtqueue, and they are processed by the
> +device in the order in which they are queued. It is the
> +responsibility of the driver to ensure ordering for commands
> +placed on different administration virtqueues, because they will
> +be executed with no order constraints.

Are all admin vqs supposed to be equal? Could a device expose e.g. a
high prio admin vq and a normal prio admin vq?

> +
> +Administration virtqueues are used as follows:
> +\begin{itemize}
> +\item Driver submits the command using the \field{struct virtio_admin_cmd}

s/Driver/The driver/

> +structure using two buffers: a device-readable one followed by a
> +device-writable one.
> +\item the device-readable buffer includes fields from \field{opcode}
> +through \field{command_specific_data}.
> +\item the device-writeable buffer includes fields from \field{status}
> +through \field{command_specific_result} inclusive.
> +\end{itemize}
> +
> +It is legal for the driver to submit commands with
> +device-writeable and device-readable structures with buffer
> +length both shorter or longer than the length of the
> +\field{command_specific_data} structure described in this
> +specification. Device silently truncates the structures to the

s/Device/The device/

> +shorter of the two lengths (submitted by driver and described in this
> +specification).

"...to either the length submitted by the driver, or the length
described in this specification, whichever is shorter."

> Device silently ignores any data falling outside

s/Device/The device/

> +the shorter of the two lengths. Any missing fields are assumed to be
> +set to zero.
> +
> +Similarly, it is legal for the device to use, for a specific
> +command, a shorter part of the \field{command_specific_result}
> +buffer than the length of the structure described in this
> +specification. Driver silently ignores any data falling outside

s/Driver/The driver/

> +the used buffer length reported by the device.  Any missing
> +fields are assumed to be set to zero.
> +
> +This simplifies driver implementations since the driver can
> +simply maintain a single large C structure for a command and its
> +result. As new versions of the specification are designed,
> +new fields can be added to the tail of a structure,
> +with driver using the full structure without concern

s/driver/the driver/

> +for versioning.
> diff --git a/content.tex b/content.tex
> index 9deacbf..d2fd1de 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>  \begin{description}
>  \item[0 to 23, and 50 to 127] Feature bits for the specific device type
>  
> -\item[24 to 40] Feature bits reserved for extensions to the queue and
> +\item[24 to 41] Feature bits reserved for extensions to the queue and
>    feature negotiation mechanisms
>  
> -\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
> +\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
>  \end{description}
>  
>  \begin{note}
> @@ -6985,6 +6985,8 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>    that the driver can reset a queue individually.
>    See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
>  
> +  \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that an administration virtqueue is supported.

"This feature indicates that the device exposes one or more
administration virtqueues." ?

> +
>  \end{description}
>  
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}


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

