Return-Path: virtio-dev-return-6295-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 16235985EFA
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Nov 2019 09:57:06 +0000 (UTC)
Date: Thu, 7 Nov 2019 10:56:57 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191107095657.72dlxzm4uz7ndkek@sirius.home.kraxel.org>
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device
 specification
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, linux-media@vger.kernel.org, tfiga@chromium.org, keiichiw@chromium.org, acourbot@chromium.org, alexlau@chromium.org, dgreid@chromium.org, marcheu@chromium.org, posciak@chromium.org, stevensd@chromium.org, hverkuil@xs4all.nl, daniel@ffwll.ch
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Nov 05, 2019 at 08:19:19PM +0100, Dmitry Sepp wrote:
> [Resend after fixing an issue with the virtio-dev mailing list]
>=20
> This patch proposes a virtio specification for a new virtio video
> device.

Hmm, quickly looking over this, it looks simliar to the vdec draft
posted a few weeks ago, with other device variants added but not
fully specified yet.

So, can you clarify the relationship between the two?

thanks,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

