Return-Path: virtio-dev-return-6789-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CCFEF985E00
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Feb 2020 16:07:25 +0000 (UTC)
Date: Wed, 26 Feb 2020 17:07:14 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200226160714.y2wt5ubtklljn576@sirius.home.kraxel.org>
References: <20200219080637.61312-1-stevensd@chromium.org>
 <20200219080637.61312-2-stevensd@chromium.org>
 <20200225061008.wqxqppfglzmwvtid@sirius.home.kraxel.org>
 <CAD=HUj7h1d8dXG94FUtj4fmeUvUM0dm6NW8WHGZAceHae0zGLw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj7h1d8dXG94FUtj4fmeUvUM0dm6NW8WHGZAceHae0zGLw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH 1/2] virtio: add dma-buf support for
 exported objects
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Linux Media Mailing List <linux-media@vger.kernel.org>, linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 26, 2020 at 12:56:58PM +0900, David Stevens wrote:
> On Tue, Feb 25, 2020 at 3:10 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > How about dma_buf_{get,set}_uuid, simliar to dma_buf_set_name?
>=20
> While I'm not opposed to such an API, I'm also hesitant to make
> changes to the dma-buf API for a single use case.

See virtio-wayland discussion.  I expect we will see more cases show up.
Maybe this should even go one level up, to struct file.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

