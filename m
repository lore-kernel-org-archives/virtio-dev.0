Return-Path: <virtio-dev-return-13309-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555BBEB64D9
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 09:57:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 77FCB2B039
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 09:57:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4D1E098680D
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 09:57:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3140E984091; Fri,  7 Jul 2023 09:57:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1E3949867EB
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Jul 2023 09:57:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: ZEDXxeMIP2WYetnp9Km6cA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688723846; x=1691315846;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dIX253dVfraFuoXO78AeOKruzKxsZtte4eZK0L+66I=;
        b=EgIoMiAnqkJZryHwNfoaXEdKaNyAoYjnOF5yoDRV/ziHPtIwvcJXt07rgNIRYgBO1s
         vVHipVodmvRQw2nV+wqSTRYmYhsF3ygnUnHO5k6gA5dQAiwy/VMnkTLFsAk0ZAuatAhj
         thuAnBqkync3Ihg9p7HjBAGkCyxcsUrTgoBd8a6dDsjcok9IP+z1rkSacZQ4ZNhNtv9P
         tQcR048dOPFP0at1C1qxWXxaclzBspWd3d4wpUn8HsBfCOJeeZ1QNw+16eD7+PIXOP9e
         Svkasb1BWMf02ZQhQR5/9ClgRxyL53vYnP8yEYVFcXdBDR8h9MYO35J7W6ZBgTpF38p4
         BCww==
X-Gm-Message-State: ABy/qLbNxSv3UANlJQFPIlqQb3xUaY2hGJl8djRkp484hUiOQVyNG97e
	ct0xFoKeVzVbdjEF49WLvqXpv682r6zXV4/U8uprw4+zJvUb+cOmOFwqoH1Ad/9TB9CTs9btaP2
	4Uwy/DnMEMZfFDx4b1q02isg4VkFl
X-Received: by 2002:adf:fc4e:0:b0:314:10d8:b491 with SMTP id e14-20020adffc4e000000b0031410d8b491mr3698236wrs.67.1688723845816;
        Fri, 07 Jul 2023 02:57:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlERWKNZgkUMMqALvFBDmlw5jND4B8XuLB6IlHMKB0k0yTjunZn48hyqZBSGBWFIzHzElcC3ig==
X-Received: by 2002:adf:fc4e:0:b0:314:10d8:b491 with SMTP id e14-20020adffc4e000000b0031410d8b491mr3698220wrs.67.1688723845511;
        Fri, 07 Jul 2023 02:57:25 -0700 (PDT)
Date: Fri, 7 Jul 2023 05:57:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com,
	marcandre.lureau@redhat.com, stefanha@redhat.com,
	viresh.kumar@linaro.org, sgarzare@redhat.com,
	takahiro.akashi@linaro.org, erik.schilling@linaro.org,
	manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Message-ID: <20230707055141-mutt-send-email-mst@kernel.org>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
 <87ilawdtug.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87ilawdtug.fsf@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user

On Fri, Jul 07, 2023 at 08:58:00AM +0100, Alex Bennée wrote:
> 
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Bennée wrote:
> >> Currently QEMU has to know some details about the back-end to be able
> >> to setup the guest. While various parts of the setup can be delegated
> >> to the backend (for example config handling) this is a very piecemeal
> >> approach.
> >
> >> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
> >> which the back-end can advertise which allows a probe message to be
> >> sent to get all the details QEMU needs to know in one message.
> >
> > The reason we do piecemeal is that these existing pieces can be reused
> > as others evolve or fall by wayside.
> 
> Sure I have no objection in principle but we then turn code like:
> 
>         if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_STANDALONE)) {
>             err = vhost_user_get_backend_specs(dev, errp);
>             if (err < 0) {
>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_specs failed");
>                 return -EPROTO;
>             }
>         }
> 
> to
> 
>         if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_ID) &&
>             dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_CFGSZ) &&
>             dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MINVQ) &&
>             dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MAXVQ)
>         ) {
>             err = vhost_user_get_virtio_id(dev, errp);
>             if (err < 0) {
>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_id failed");
>                 return -EPROTO;
>             }
>             err = vhost_user_get_virtio_cfgsz(dev, errp);
>             if (err < 0) {
>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_cfgsz failed");
>                 return -EPROTO;
>             }
>             err = vhost_user_get_virtio_minvq(dev, errp);
>             if (err < 0) {
>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_minvq failed");
>                 return -EPROTO;
>             }
>             err = vhost_user_get_virtio_maxvq(dev, errp);
>             if (err < 0) {
>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_maxvq failed");
>                 return -EPROTO;
>             }
>             dev->specs.valid = true;
>         }
> 
> for little gain IMHO.
>
> > For example, I can think of instances where you want to connect
> > specifically to e.g. networking backend, and specify it
> > on command line. Reasons could be many, e.g. for debugging,
> > or to prevent connecting to wrong device on wrong channel
> > (kind of like type safety).
> 
> I don't quite follow what you are trying to say here.

That some or all of these might be better on qemu command line
not come from backend. Then we'll want to *send* it to backend.
All this at our discretion without protocol changes.


> > What is the reason to have 1 message? startup latency?
> > How about we allow pipelining several messages then?
> > Will be easier.
> 
> I'm not overly worried about performance because this is all at
> start-up. I am worried about excessive complexity though. We already
> have quite a lot of interacting protocol messages.
> 
> >
> >
> >> 
> >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >> 
> >> ---
> >> Initial RFC for discussion. I intend to prototype this work with QEMU
> >> and one of the rust-vmm vhost-user daemons.
> >> ---
> >>  docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
> >>  hw/virtio/vhost-user.c      |  8 ++++++++
> >>  2 files changed, 45 insertions(+)
> >> 
> >> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> >> index 5a070adbc1..85b1b1583a 100644
> >> --- a/docs/interop/vhost-user.rst
> >> +++ b/docs/interop/vhost-user.rst
> >> @@ -275,6 +275,21 @@ Inflight description
> >>  
> >>  :queue size: a 16-bit size of virtqueues
> >>  
> >> +Backend specifications
> >> +^^^^^^^^^^^^^^^^^^^^^^
> >> +
> >> ++-----------+-------------+------------+------------+
> >> +| device id | config size |   min_vqs  |   max_vqs  |
> >> ++-----------+-------------+------------+------------+
> >> +
> >> +:device id: a 32-bit value holding the VirtIO device ID
> >> +
> >> +:config size: a 32-bit value holding the config size (see ``VHOST_USER_GET_CONFIG``)
> >> +
> >> +:min_vqs: a 32-bit value holding the minimum number of vqs supported
> >> +
> >> +:max_vqs: a 32-bit value holding the maximum number of vqs supported, must be >= min_vqs
> >> +
> >
> > looks like a weird set of info.
> 
> It's basically the information you need for -device vhost-user-device to
> start-up (and what is essentially the information set by the stubs as
> they start-up).
> 
> > why would we want # of vqs and not their sizes?
> 
> I thought the vring's themselves where allocated by the driver. We only
> need to the number of vqs so we can allocate the tracking structures.

size is specified by device though

> > why config size but not config itself?
> 
> We already have GET_CONFIG and SET_CONFIG but without knowing the size
> of the config space we can't properly set it up.

I don't get it. each message includes size already.

> <snip>
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

