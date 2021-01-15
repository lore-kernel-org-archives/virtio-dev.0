Return-Path: virtio-dev-return-7921-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF668986545
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Jan 2021 16:55:54 +0000 (UTC)
References: <20200623111325.237158-1-keiichiw@chromium.org>
 <87czy7l6uu.fsf@linaro.org>
 <CAD90Vca=VPVM7+Cj-2cK3SWaSR_Ciajt7oOr0OyB-34bL15ewg@mail.gmail.com>
From: Matti Moell <Matti.Moell@opensynergy.com>
Message-ID: <f3b177a7-1792-25ff-5bef-9e6b7fb4bde3@opensynergy.com>
Date: Fri, 15 Jan 2021 17:55:50 +0100
MIME-Version: 1.0
In-Reply-To: <CAD90Vca=VPVM7+Cj-2cK3SWaSR_Ciajt7oOr0OyB-34bL15ewg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH RFC v4 0/1] Virtio Video Device Specification
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?St=c3=a9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Kiran Pawar <kiran.pawar@opensynergy.com>, Saket Sinha <saket.sinha89@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Nicolas Dufresne <nicolas@ndufresne.ca>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, Ruchika Gupta <ruchika.gupta@linaro.org>, Peter Griffin <peter.griffin@linaro.org>, Mike Holmes <mike.holmes@linaro.org>, dmitry.sepp@outlook.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 15.01.21 15:25, Keiichi Watanabe wrote:
> I think the driver implementation is necessary for the spec to be
> merged, but it's not yet clear when we can spend time implementing
> drivers. It's likely to be after April or so.
> 
> IIRC, OpenSynergy folks, who implemented the v3 driver, also had some
> plan to implement the driver with the v5 spec.
> Matti, do you have any update on it? I'd really appreciate it if we
> could keep working for upstream together.

Hey Keiichi and Alex!

Yeah, I think for us it'll also be in the March/April timeline before we
can start looking at it again, there's quite a few loose ends when going
from v3 to v5 so it'll probably take a while to get it in shape and make
sure that all the comments from the drivers v2 are properly addressed.

I'm not 100% sure how to proceed but perhaps it makes sense to jointly
iterate on the driver sources together once the v5 is mostly agreed. Any
suggestions welcome.

Cheers,

		Matti


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

