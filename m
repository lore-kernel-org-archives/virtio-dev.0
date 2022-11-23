Return-Path: <virtio-comment-return-3503-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221122142054-mutt-send-email-mst@kernel.org>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-6-mst@redhat.com> <87zgcjdp2p.fsf@redhat.com>
 <20221122142054-mutt-send-email-mst@kernel.org>
Date: Wed, 23 Nov 2022 10:36:25 +0100
Message-ID: <87k03mnhba.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v8 5/9] pci: add admin vq registers to virtio over pci
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Nov 22 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Nov 22, 2022 at 03:46:38PM +0100, Cornelia Huck wrote:
>> On Sun, Nov 20 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > Add new registers to the PCI common configuration structure.
>> >
>> > These registers will be used for querying the indices of the admin
>> > virtqueues of the owner device. To configure, reset or enable the admin
>> > virtqueues, the driver should follow existing queue configuration/setup
>> > sequence.
>> >
>> > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > ---
>> >  content.tex | 34 ++++++++++++++++++++++++++++++++++
>> >  1 file changed, 34 insertions(+)
>> 
>> (...)
>> 
>> > @@ -1112,6 +1129,14 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>> >  were used before the queue reset.
>> >  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>> >  
>> > +If VIRTIO_F_ADMIN_VQ has been negotiated, and if the driver
>> > +configures any administration virtqueues, the driver MUST
>> > +configure the administration virtqueues using the index
>> > +in the range \field{admin_queue_index} to
>> > +\field{admin_queue_index} + \field{admin_queue_num} inclusive.
>> > +The driver MAY configure less administration virtqueues than
>> > +supported by the device.
>> 
>> Is the driver allowed to pick any admin queue from within the range,
>> e.g. queues 2 and 5, and leave the rest?
>
> I was split on this. In the end I don't see why not.
> Do you feel we need to document this?

It should work fine, I guess; probably no need to spell it out
explicitly.

>
>> > +
>> >  \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
>> >  
>> >  The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
>> > @@ -6986,6 +7011,15 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>> >    See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
>> >  
>> >    \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that an administration virtqueue is supported.
>> > +  At the moment this feature is only supported for devices using
>> > +  \ref{sec:Virtio Transport Options / Virtio Over PCI
>> > +	  Bus}~\nameref{sec:Virtio Transport Options / Virtio Over PCI Bus}
>> > +	  as the transport and is reserved for future use for
>> > +	  devices using other transports (see
>> > +	  \ref{drivernormative:Basic Facilities of a Virtio Device / Feature Bits}
>> > +	and
>> > +	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits} for
>> > +	handling features reserved for future use.
>> >  
>> >  \end{description}
>> >  
>> 
>> We don't say for any other feature which transports support it; do we
>> really need to state it here explicitly if we have the rules for
>> reserved feature bits in place? It simply will be neither offered nor
>> accepted if the device and driver use an unsupported transport.
>
> It's just easy for someone to add code for feature in transport
> agnostic part and then it will be negotiated mistakenly when
> we add it for a new transport.
> Potential for such a bug is what worries me and this is why I add
> this in so many places. Harmless no?

By this reasoning, we probably should also add a comment for
NOTIFICATION_DATA and RING_RESET? (On top, of course.)


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

