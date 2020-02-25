Return-Path: virtio-dev-return-6776-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F227E985D55
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Feb 2020 10:01:55 +0000 (UTC)
Date: Tue, 25 Feb 2020 11:01:44 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200225100144.c3rmtmq7kqyskkq7@sirius.home.kraxel.org>
References: <20200206102058.247258-1-keiichiw@chromium.org>
 <20200206102058.247258-3-keiichiw@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20200206102058.247258-3-keiichiw@chromium.org>
Subject: [virtio-dev] Re: [PATCH v3 2/2] virtio-video: Define a feature for exported
 objects from different virtio devices
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, linux-media@vger.kernel.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, dstaessens@chromium.org, dmitry.sepp@opensynergy.com, egranata@google.com, fziglio@redhat.com, hverkuil@xs4all.nl, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com, samiullah.khawaja@opensynergy.com, kiran.pawar@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> +        /*
> +         * Followed by either
> +         * - struct virtio_video_mem_entry entries[]
> +         *   for VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES
> +         * - struct virtio_video_object_entry entries[]
> +         *   for VIRTIO_VIDEO_MEM_TYPE_VIRTIO_OBJECT

Wouldn't that be a single virtio_video_object_entry?
Or could it be one per plane?

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

