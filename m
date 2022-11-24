Return-Path: <virtio-dev-return-10264-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C89009864E9
	for <virtio-dev@lists.oasis-open.org>; Thu, 24 Nov 2022 12:06:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221124031018-mutt-send-email-mst@kernel.org>
References: <20221123210706.21476-1-mst@redhat.com>
 <20221123210706.21476-2-mst@redhat.com>
 <CACGkMEtk6YLic7zjDj-yd36piLSjx5h18eXYs4rKD=uKdqprzw@mail.gmail.com>
 <20221124015254-mutt-send-email-mst@kernel.org>
 <CACGkMEuxYxXU+bYGh79=-KzRRKA-hTvEkTbxej7c=8dB_Q_jZA@mail.gmail.com>
 <20221124031018-mutt-send-email-mst@kernel.org>
Date: Thu, 24 Nov 2022 13:05:58 +0100
Message-ID: <87k03kh80p.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v9 01/10] virtio: document forward compatibility guarantees
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 24 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Nov 24, 2022 at 03:34:19PM +0800, Jason Wang wrote:
>> On Thu, Nov 24, 2022 at 2:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>> >
>> > On Thu, Nov 24, 2022 at 12:33:52PM +0800, Jason Wang wrote:
>> > > On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>> > > >
>> > > > Feature negotiation forms the basis of forward compatibility
>> > > > guarantees of virtio but has never been properly documented.
>> > > > Do it now.
>> > > >
>> > > > Suggested-by: Halil Pasic <pasic@linux.ibm.com>
>> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> > > > ---
>> > > >  content.tex | 42 ++++++++++++++++++++++++++++++++++++++++++
>> > > >  1 file changed, 42 insertions(+)
>> > > >
>> > > > diff --git a/content.tex b/content.tex
>> > > > index 3051399..e3203be 100644
>> > > > --- a/content.tex
>> > > > +++ b/content.tex
>> > > > @@ -114,21 +114,63 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
>> > > >  In particular, new fields in the device configuration space are
>> > > >  indicated by offering a new feature bit.
>> > > >
>> > > > +To keep te feature negotiation mechanism extensible, it is important
>> > > > +that devices \em{do not} offer any feature bits that they would not be
>> > > > +able to handle if the driver accepted them (even though drivers are not
>> > > > +supposed to accept them in the first place even if offered, according to
>> > > > +this version of the specification.)
>> > >
>> > > It looks to me if we want to clarify like this, feature negotiation is
>> > > not sufficient. Do we need to do something similar in other basic
>> > > facilities? Generally, we probably need to do this for facilities that
>> > > are similar to features (status, virtqueue size and others).
>> >
>> > I'm not sure about "not sufficient". It's sufficient as long
>> > as you just want to extend features. What triggered this
>> > work is adding a transport specific feature.
>> 
>> E.g:
>> 
>> For status: Devices do not offer any status bit it would not be able to handle.
>> For virtqueue size:  Devices do not offer virtqueue size it would not
>> be able to handle.
>> 
>> ?
>
> Jason I think what you miss here is this part:
>
> "even though drivers are not
> supposed to accept them in the first place even if offered, according to
> this version of the specification"
>
> does not apply to status and virtqueue size.
>
>
> Let me clarify what all this means.
> It seems safe for a device to offer a reserved feature bit
> since drivers are not supposed to accept it.
> This text says device must not rely on this.
>
> How would this apply to status or vq size? I don't see.

Me neither... for the status, it's about either the driver noting its
progress, or the device indicating that a reset is needed. The only case
where setting something requires kind of an ack is FEATURES_OK, and
there we already spell out the conditions clearly. For the queue size,
we specify that the device states what it can support, and that the
driver may only reduce it, that seems clear enough to me.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

