Return-Path: virtio-dev-return-5390-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E7F2C985C8A
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Feb 2019 16:58:09 +0000 (UTC)
Date: Mon, 11 Feb 2019 11:57:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190211103652-mutt-send-email-mst@kernel.org>
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain>
 <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org>
 <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 11, 2019 at 07:14:53AM -0800, Frank Yang wrote:
>=20
>=20
> On Mon, Feb 11, 2019 at 6:49 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
>     On Mon, Feb 04, 2019 at 11:42:25PM -0800, Roman Kiryanov wrote:
>     > Hi Gerd,
>     >
>     > > virtio-gpu specifically needs that to support vulkan and opengl
>     > > extensions for coherent buffers, which must be allocated by the h=
ost
>     gpu
>     > > driver.=A0 It's WIP still.
>     >
>     > the proposed spec says:
>     >
>     > +Shared memory regions MUST NOT be used to control the operation
>     > +of the device, nor to stream data; those should still be performed
>     > +using virtqueues.
>     >
>     > Is there a strong reason to prohibit using memory regions for contr=
ol
>     purposes?
>=20
>     That's in order to make virtio have portability implications, such th=
at if
>     people see a virtio device in lspci they know there's
>     no lock-in, their guest can be moved between hypervisors
>     and will still work.
>=20
>     > Our long term goal is to have as few kernel drivers as possible and=
 to
>     move
>     > "drivers" into userspace. If we go with the virtqueues, is there
>     > general a purpose
>     > device/driver to talk between our host and guest to support custom
>     hardware
>     > (with own blobs)?
>=20
>     The challenge is to answer the following question:
>     how to do this without losing the benefits of standartization?
>=20
>=20
> Draft spec is incoming, but the basic idea is to standardize how to enume=
rate,
> discover, and operate (with high performance) such userspace drivers/devi=
ces;
> the basic operations would be standardized, and userspace drivers would be
> constructed out of the resulting primitives.

As long standartization facilitates functionality, e.g.
if we can support moving between hypervisors, this seems
in-scope for virtio.


>     > Could you please advise if we can use something else to
>     > achieve this goal?
>=20
>     I am not sure what the goal is though. Blobs is a means I guess
>     or it should be :) E.g. is it about being able to iterate quickly?
>=20
>     Maybe you should look at vhost-user-gpu patches on qemu?
>     Would this address your need?
>     Acks for these patches would be a good thing.
>=20
>=20
>=20
> Is this it:
>=20
> https://patchwork.kernel.org/patch/10444089/ ?
>=20
> I'll check it out and try to discuss. Is there a draft spec for it as wel=
l?


virtio gpu is part of the csprd01 draft.

>=20
>=20
>     --
>     MST
>=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

