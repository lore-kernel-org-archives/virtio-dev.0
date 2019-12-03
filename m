Return-Path: virtio-dev-return-6449-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 642D1985EE2
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Dec 2019 09:33:27 +0000 (UTC)
Date: Tue, 3 Dec 2019 10:33:22 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191203093322.gu2zmmgzuqekho4n@sirius.home.kraxel.org>
References: <20191128131941.25069-1-kraxel@redhat.com>
 <3815f3b3-135a-97ae-8f4a-0eee8cca81bb@opensynergy.com>
 <20191129053658.bwessuw3lrvpjqzk@sirius.home.kraxel.org>
 <CAEkmjvW2LbWSuSixU_YWziFjfMw0pLW-EzCAoGvJ8Er34VkZ1Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEkmjvW2LbWSuSixU_YWziFjfMw0pLW-EzCAoGvJ8Er34VkZ1Q@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] virtio-gpu: add shared resource feature
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Frank Yang <lfy@google.com>
Cc: Matti Moell <Matti.Moell@opensynergy.com>, virtio-dev@lists.oasis-open.org, Gurchetan Singh <gurchetansingh@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Dec 02, 2019 at 09:24:31AM -0800, Frank Yang wrote:
> Interesting; what's the use case for this?

Mostly reduce data copying.

> Do we already have a mechanism
> to import memory to virtio-gpu via importing a bo handle from somewhere
> else?

Inside the guest?  Import is not working yet, that needs another update
(blob resources) due to current virtio-gpu resources requiring a format
at creation time and dmabufs not having one.

See https://www.kraxel.org/blog/2019/11/virtio-gpu-status-and-plans/ for
some background.

Exporting virtio-gpu resources works in the drm-misc-next branch, should
land in mainline this merge window (i.e. 5.5-rc1).

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

