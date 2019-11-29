Return-Path: virtio-dev-return-6427-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D9CC985EF6
	for <virtio-dev@lists.oasis-open.org>; Fri, 29 Nov 2019 05:37:04 +0000 (UTC)
Date: Fri, 29 Nov 2019 06:36:58 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191129053658.bwessuw3lrvpjqzk@sirius.home.kraxel.org>
References: <20191128131941.25069-1-kraxel@redhat.com>
 <3815f3b3-135a-97ae-8f4a-0eee8cca81bb@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <3815f3b3-135a-97ae-8f4a-0eee8cca81bb@opensynergy.com>
Subject: Re: [virtio-dev] [PATCH] virtio-gpu: add shared resource feature
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Matti Moell <Matti.Moell@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Gurchetan Singh <gurchetansingh@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 28, 2019 at 07:04:23PM +0100, Matti Moell wrote:
> Hi Gerd,
>=20
> I really like this!
>=20
> On 28.11.19 14:19, Gerd Hoffmann wrote:
> > @@ -186,6 +211,7 @@ \subsubsection{Device Operation: Request header}\la=
bel{sec:Device Types / GPU De
> >           VIRTIO_GPU_CMD_GET_CAPSET_INFO,
> >           VIRTIO_GPU_CMD_GET_CAPSET,
> >           VIRTIO_GPU_CMD_GET_EDID,
> > +        VIRTIO_GPU_CMD_RESOURCE_CREATE_2D_SHARED,
> Shouldn't there also the RESOURCE_CREATE_3D_SHARED? I know that 3D isn't
> speced here but it looks awkward not to reserve it.

Yep, none of the 3D commands is in the specs, thats why
RESOURCE_CREATE_3D_SHARED isn't there too (but, yes, it exists).

Guess it might be a good idea to at least list the commands,
but that is something for a separate patch ...

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

