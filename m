Return-Path: virtio-dev-return-7178-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6560B985BA9
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Apr 2020 14:29:49 +0000 (UTC)
From: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Date: Mon, 27 Apr 2020 16:28:28 +0200
Message-ID: <36408073.J2Yia2DhmK@os-lin-dmo>
In-Reply-To: <CAD90VcZpXevAF9=d1FvdHyGkU3ShKWga+_AhPWN4BBFTTRY1aQ@mail.gmail.com>
References: <20200206102058.247258-1-keiichiw@chromium.org> <3597088.V25eIC5XRa@os-lin-dmo> <CAD90VcZpXevAF9=d1FvdHyGkU3ShKWga+_AhPWN4BBFTTRY1aQ@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v3 1/2] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 7Bit
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: Alexandre Courbot <acourbot@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Keiichi,

Thanks for the update.

> > Thanks for providing this detailed overview. But again, we have already
> > discussed this in a similar way and it does not answer the questions. Ok,
> > suppose we set bitrate to 0xffffffff as I assumed above. Then the decoder
> > code should ideally wait until metadata has been parsed, then query
> > parameters and get min buffers (using get_params). Encoder does not have
> > such logic. What values should we set for encoder to make sure that the
> > pipelines does not stall? Probably people from the Chromium team has
> > better knowledge, if they can provide some sane value it'd be just great.
> 
> Sorry that my explanation was unclear to you.  Let me try to explain
> my idea in another way.
> 
> The design I'm proposing can be seen as a kind of "Copy-on-Write"
> strategy. The resource creation can be deferred to the first write.
> In other words, the call of STREAM_CREATE can be delayed to the first
> place where a user makes a change to the stream, instead of open().
> The code snippet I wrote above explains a general way of achieving
> CoW. In this design, ctx2stream() will be called when modifying a
> stream.
> 
> In the V4L2 stateful encoder API, the first place in which a user
> writes values is the first call of VIDIOC_S_FMT().
> So, we can have a virtio_video_cmd_stream_cmd() call in the callback
> for VIDIOC_S_FMT. I guess it's even better than my previous proposal
> of ctx2stream, as the driver can raise an error when a user calls
> ioctls in a wrong order.
> (I think I said that the place would be REQBUFS callback in a previous
> review comment to your patch. It was my misunderstanding. My
> apologies.)
> 
> Does it make sense? I hope this answers your question.

I had understood the idea behind the proposal. But I didn't see a correct way 
to implement that. But now it looks different of course. The decoder should 
also be fine if we create a stream on S_FMT.

Best regards,
Dmitry.

> 
> Best regards,
> Keiichi
> 



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

