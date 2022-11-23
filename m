Return-Path: <virtio-dev-return-10210-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 554379864B3
	for <virtio-dev@lists.oasis-open.org>; Wed, 23 Nov 2022 09:21:59 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221122151818-mutt-send-email-mst@kernel.org>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-2-mst@redhat.com> <87tu2s5o0l.fsf@redhat.com>
 <20221122151818-mutt-send-email-mst@kernel.org>
Date: Wed, 23 Nov 2022 10:21:52 +0100
Message-ID: <87sfianhzj.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v8 1/9] virtio: document forward compatibility guarantees
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Nov 22 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Nov 21, 2022 at 04:24:26PM +0100, Cornelia Huck wrote:
>> On Sun, Nov 20 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >  \drivernormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device / Feature Bits}
>> >  The driver MUST NOT accept a feature which the device did not offer,
>> >  and MUST NOT accept a feature which requires another feature which was
>> >  not accepted.
>> >  
>> > +The driver MUST validate the feature bits offered by the device.
>> > +The driver MUST ignore and MUST NOT accept feature bits not
>> > +described in this specification, reserved feature bits and
>> > +feature bits reserved or not supported for the specific transport
>> > +or the specific device type.
>> 
>> I think we can mandate that the driver MUST NOT accept these feature
>> bits; but can we mandate that it MUST ignore them? Alternatively, it
>> could also set the FAILED status bit.
>
> Well if drivers assume there are no
> new features then we can't add new ones and forward compatibility
> breaks. We always assumed drivers ignore features they don't
> understand.  This is why I propose mandating this strongly and
> I feel it's okay to add such a requirement even at this late stage
> anything violating this would have been broken many times already.
> No?

Hm, right. Let's keep this as MUST.

>
>> Also, what does "specific device type" mean in this case? Does it refer
>> to a driver that supports devices virtio-foo, virtio-bar, and
>> virtio-baz, and so needs to ignore a feature that is only valid for
>> virtio-foo, but not for virtio-bar or virtio-baz, if it is offered for
>> anything that is not virtio-foo?
>
> For example, virtio-rng has no features, driver must ignore
> all device specific feature bits and only negotiate generic
> and transport specific feature bits.

Isn't that the same as a feature bit that the driver does not know?
Feature bit 0 means different things for different device types, and for
virtio-rng, it's simply an undefined feature (as of now).

> How would you put it better?

Let me try:

The driver MUST ignore and MUST NOT accept any feature bit that is
\begin{itemize}
\item not described in this specification,
\item marked as reserved,
\item not supported for the specific transport,
\item not defined for the device type.
\end{itemize}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

