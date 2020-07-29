Return-Path: virtio-dev-return-7621-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 35ACF985D5D
	for <virtio-dev@lists.oasis-open.org>; Wed, 29 Jul 2020 13:53:05 +0000 (UTC)
Date: Wed, 29 Jul 2020 09:52:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200729094956-mutt-send-email-mst@kernel.org>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-2-ndragazis@arrikto.com>
 <87v9inv26c.fsf@linaro.org>
 <20200717092635.GB128195@stefanha-x1.localdomain>
 <20200724103627-mutt-send-email-mst@kernel.org>
 <f6e7491b-127e-30e3-99ca-de1aa8c6527e@arrikto.com>
 <20200727122521.GA386429@stefanha-x1.localdomain>
 <21ded3b5-1337-960b-b8ee-bdf6dea4eb93@arrikto.com>
MIME-Version: 1.0
In-Reply-To: <21ded3b5-1337-960b-b8ee-bdf6dea4eb93@arrikto.com>
Subject: Re: [virtio-dev] [PATCH v5 01/10] vhost-user: add vhost-user device
 type
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jul 27, 2020 at 09:59:36PM +0300, Nikos Dragazis wrote:
> On 27/7/20 3:25 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:
>=20
> > On Fri, Jul 24, 2020 at 08:31:48PM +0300, Nikos Dragazis wrote:
> > > On 24/7/20 5:41 =CE=BC.=CE=BC., Michael S. Tsirkin wrote:
> > > > On Fri, Jul 17, 2020 at 10:26:35AM +0100, Stefan Hajnoczi wrote:
> > > > So how about XXX notifications for both of these things?
> > > > Where XXX explains what is the reason for triggering each
> > > > type of notification.
> > > I guess Stefan introduced the term "doorbell" because it is a widely
> > > used term (e.g., in NVMe devices) and I think it is a pretty good
> > > term. However, I agree that the vague term "notification" may cause
> > > confusion.
> > >=20
> > > Replacing "doorbells" and "notifications" with "XXX notifications"
> > > sounds good. I can't think of some good terms for XXX right now.
> > > Feel free to propose.
> > Device-specific notifications and device-specific doorbells?

Um. What does this mean exactly?
Really I am guessing you are notifying about some kind of event.
So let's call it according to this event then.

> >=20
> > I think these concepts should be part of the core VIRTIO device model s=
o
> > that other devices can also define device-specific
> > notifications/doorbells in the future.
> >=20
> > Stefan
>=20
> I think that Michael is OK with standardizing these resources, but he is
> not really happy with the term "doorbell".
>=20
> From the one hand, using the term "XXX notification" would be more
> consistent with the virtio spec, since virtio already uses the term
> "notification" for driver-to-device signaling regarding the virtqueues.
>=20
> On the other hand, I can't find something for XXX that would sound
> better than "doorbell".
>=20
> But let's see what Michael has to say.
>=20
> Nikos

"doorbells" is generally like available buffer notifications that we
have in virtio. I am still not sure what does it mean in this context.

--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

