Return-Path: virtio-dev-return-6685-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4222D985F97
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Jan 2020 10:36:14 +0000 (UTC)
MIME-Version: 1.0
References: <CAD=HUj7N8dpEvf0Be8fg-qpFFTQOqzZX_kVoFB=BWp8S4uEFvg@mail.gmail.com>
 <20200122032433-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200122032433-mutt-send-email-mst@kernel.org>
From: David Stevens <stevensd@chromium.org>
Date: Wed, 22 Jan 2020 19:36:01 +0900
Message-ID: <CAD=HUj7cXK65Hj1rrL9KKoa6oWzBBwf8J_kSU2beJwzD4q06Fw@mail.gmail.com>
Subject: Re: [virtio-dev][RFC PATCH v1 2/2] virtio-gpu: add the ability to
 export resources
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>, Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> ok but how is this then used? will there be more commands to pass
> this uuid to another device?

This is intended to be used with the virtio video device being
discussed here https://markmail.org/thread/ingyqlps4rbcuazh. I don't
have a specific patch for how that will work, but it will likely be an
extension to VIRTIO_VIDEO_T_RESOURCE_CREATE.

> > +The response contains a uuid which identifies the exported object crea=
ted from
> > +the host private resource.
>
> Are the uuids as specified in rfc-4122? I guess we need to link to that s=
pec then

I don't think it's terribly important to specify how the uuids are
generated, as long as they're actually unique. That being said, I'm
not opposed to defining them as rfc-4122 version 4 uuids. Although if
we do that, it should go in the patch that defines what exported
objects and uuids are in the context of virtio, not in the virtio-gpu
section.

> > Note that if the resource has an attached backing,
> > +modifications made to the host private resource through the exported o=
bject by
> > +other devices are not visible in the attached backing until they are
> > transferred
> > +into the backing.
> > +
>
> s/host/device/?

The virtio-gpu is based around "resources private to the host", to
quote the existing specification. I think consistency with that
language is important.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

