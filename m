Return-Path: <acourbot@chromium.org>
MIME-Version: 1.0
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <87bkoehrds.fsf@redhat.com> <CAPBb6MWyRTNPg4G5WQLVxeGi6M+pZRnzR5NEYjjGbq+YjsKUkg@mail.gmail.com>
 <871qo1xxvu.fsf@redhat.com>
In-Reply-To: <871qo1xxvu.fsf@redhat.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Thu, 12 Jan 2023 15:32:40 +0900
Message-ID: <CAPBb6MWco8YkSTNXyBFzOPp3nq6cCDSVWsFcuoT+gTwPqHdwXA@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC PATCH v6] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=C3=B6ll?= <Matti.Moell@opensynergy.com>, Andrew Gazizov <andrew.gazizov@opensynergy.com>, Enrico Granata <egranata@google.com>, Gustavo Padovan <gustavo.padovan@collabora.com>, Peter Griffin <peter.griffin@linaro.org>, =?UTF-8?Q?Bart=C5=82omiej_Grzesik?= <bag@semihalf.com>, Tomasz Figa <tfiga@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Cornelia,

On Wed, Jan 11, 2023 at 5:45 PM Cornelia Huck <cohuck@redhat.com> wrote:
> >> > +
> >> > +The device MUST set the \field{caps_length} field to a value equal to
> >> > +the response size of VIRTIO\_VIDEO\_CMD\_DEVICE\_QUERY\_CAPS.
> >>
> >> Could the device also support a minimum response size that only supports
> >> a subset of the caps to be returned? Otherwise, I think caps_length is
> >> the maximum (or fixed?) length of the query caps response?
> >
> > I think this can be replaced by a fixed-size call for getting only one
> > format at a time. The guest would have to make several of these in
> > order to obtain the whole set of supported formats, but it would be
> > easier to parse compared to the large result returned by QUERY_CAP and
> > simpler overall.
>
> How would you implement this? Would the driver do the call repeatedly
> until no more formats remain (requires the device to track state, and
> needs a specification on what happens if the driver continues doing the
> call?) Or would the driver pass in an index, and the device only needs
> to check for out-of-range?

One peculiarity of codecs is that the pixel formats available may
depend on the coded format (and sometimes even its resolution). For
instance, NV12 may be available if you do VP8 at 1080p but not 4K
H.264.

This means that a single call returning all the coded and pixel
formats won't be able to convey all the possible subtleties. In
previous versions of this spec we used bitmasks to associate pixel
formats to their supported coded formats, but it's a bit of a pain to
manage while still not bringing the necessary precision.

So here again the safe way is to follow the V4L2 lead: get a list of
supported bitstream formats (one at a time, using an index with a
range defined by the configuration space), apply the one we are
interested in, and query the supported pixel formats for that specific
bitstream format using the same mechanism. That's more back-and-forth
between the guest and the host, but it happens before streaming starts
and better reflects the actual decoding workflow where the client is
typically only interested in the supported formats for the codec they
want to decode.

> >> Generally, I don't see anything fundamentally wrong with this approach
> >> (mostly some smaller nits.) Feedback from someone familiar with this
> >> subject would be great, though.
> >
> > Thanks, that's encouraging! There are still a few bits missing, and we
> > may switch to something different if we decide to piggyback V4L2, but
> > the core mechanisms will remain similar so it is great to see that
> > there isn't any hard blocker.
>
> Let's see how we can move this forward to something that can be
> included in the spec, always good to see a new, useful device!

Thanks! I guess the main decision will be whether to follow this spec
or switch to encapsulating V4L2, but we will be able to progress
either way. I'll try to present the benefits of the V4L2-over-virtio
solution later in this thread.

Cheers,
Alex.

