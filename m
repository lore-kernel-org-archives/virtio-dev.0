Return-Path: <virtio-dev-return-13412-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAACC0015E
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Jul 2023 16:02:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7D31329FC8
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Jul 2023 16:02:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7523C9866C3
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Jul 2023 16:02:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6407D9866BE; Wed, 26 Jul 2023 16:02:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 520B39866BF
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Jul 2023 16:02:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: YkOx1YI6OyWi7Ff5kErTkw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690387366; x=1690992166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZZLy8l+7VAilXfQQ7ZH9vv3kVijAPeW8XYe8UBV+I4=;
        b=eZ0+gVnRzTkgk2oWttV0X7+Oai72sTAqudbBvsQZR+aKZvrSbz5/b0Bb79Mchnn85v
         YT6ocljiQRuIpoL/VsS3Myd+lFeLfK87SVSj3CxRbb9bN61ZxN9SkxKD+4HfQm6paXlv
         Vjx0Yda8DHLZmcFofEXQGsZ6NSeweFUoZ+4TzaM6lG/JNH7EL7pxDcgzqU9ioQNgnZdG
         30bou6nSdxp0ltBwFONPX+AR/II+dnAIGBzs+6kB9ZSfOv7yt89S5DesXLUprBznkshd
         jj+IjLBaHiPLvunTd/DB2PnPTe0vXPeU+4AmxnWK/IQcMnJAPnAs9bfIz5ILErmanHhm
         1Gng==
X-Gm-Message-State: ABy/qLYNAcO/zZ6dd5W9IaS00L1UhofVMCgsJ1E77Ad6iQdzcxNVcul/
	Ny76unYcDJdQ5922mEeLxEDmx7M2MJTf5d3fhSRAK2/majwKCXaqhCDxdLC7+MpWnVxOhG+QLa1
	F/lox10goEadwUEle/6xGc8AKdXW0
X-Received: by 2002:a5d:6a85:0:b0:317:61d8:3c7e with SMTP id s5-20020a5d6a85000000b0031761d83c7emr1689610wru.26.1690387365976;
        Wed, 26 Jul 2023 09:02:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlENEFAIWEpwv+cBFcnxTKpWLe+SVN6Bhmmem6FbzFvp+dXBQq4UD/En9Br0bdMc6cm8D1+Flg==
X-Received: by 2002:a5d:6a85:0:b0:317:61d8:3c7e with SMTP id s5-20020a5d6a85000000b0031761d83c7emr1689587wru.26.1690387365626;
        Wed, 26 Jul 2023 09:02:45 -0700 (PDT)
Date: Wed, 26 Jul 2023 12:02:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
	slp@redhat.com, marcandre.lureau@redhat.com,
	viresh.kumar@linaro.org, sgarzare@redhat.com,
	takahiro.akashi@linaro.org, erik.schilling@linaro.org,
	manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Message-ID: <20230726120158-mutt-send-email-mst@kernel.org>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
 <20230720195837.GJ210977@fedora>
 <20230720171321-mutt-send-email-mst@kernel.org>
 <CAJSP0QVDBA0Fb+LVjJVWq7Dp7FosXAJsRJUCcAtdNr-VyzYipg@mail.gmail.com>
 <20230720182128-mutt-send-email-mst@kernel.org>
 <20230724180839.GC222590@fedora>
MIME-Version: 1.0
In-Reply-To: <20230724180839.GC222590@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user

On Mon, Jul 24, 2023 at 02:08:39PM -0400, Stefan Hajnoczi wrote:
> On Thu, Jul 20, 2023 at 06:22:08PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jul 20, 2023 at 05:31:03PM -0400, Stefan Hajnoczi wrote:
> > > On Thu, 20 Jul 2023 at 17:15, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Jul 20, 2023 at 03:58:37PM -0400, Stefan Hajnoczi wrote:
> > > > > On Thu, Jul 06, 2023 at 12:48:20PM -0400, Michael S. Tsirkin wrote:
> > > > > > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Bennée wrote:
> > > > > > > Currently QEMU has to know some details about the back-end to be able
> > > > > > > to setup the guest. While various parts of the setup can be delegated
> > > > > > > to the backend (for example config handling) this is a very piecemeal
> > > > > > > approach.
> > > > > >
> > > > > > > This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
> > > > > > > which the back-end can advertise which allows a probe message to be
> > > > > > > sent to get all the details QEMU needs to know in one message.
> > > > > >
> > > > > > The reason we do piecemeal is that these existing pieces can be reused
> > > > > > as others evolve or fall by wayside.
> > > > > >
> > > > > > For example, I can think of instances where you want to connect
> > > > > > specifically to e.g. networking backend, and specify it
> > > > > > on command line. Reasons could be many, e.g. for debugging,
> > > > > > or to prevent connecting to wrong device on wrong channel
> > > > > > (kind of like type safety).
> > > > > >
> > > > > > What is the reason to have 1 message? startup latency?
> > > > > > How about we allow pipelining several messages then?
> > > > > > Will be easier.
> > > > >
> > > > > This flag effectively says that the back-end is a full VIRTIO device
> > > > > with a Device Status Register, Configuration Space, Virtqueues, the
> > > > > device type, etc. This is different from previous vhost-user devices
> > > > > which sometimes just offloaded certain virtqueues without providing the
> > > > > full VIRTIO device (parts were emulated in the VMM).
> > > > >
> > > > > So for example, a vhost-user-net device does not support the controlq.
> > > > > Alex's "standalone" device is a mode where the vhost-user protocol is
> > > > > used but the back-end must implement a full virtio-net device.
> > > > > Standalone devices are like vDPA device in this respect.
> > > > >
> > > > > I think it is important to have a protocol feature bit that advertises
> > > > > that this is a standalone device, since the semantics are different for
> > > > > traditional vhost-user-net devices.
> > > >
> > > > Not sure what that would gain as compared to a feature bit per
> > > > message as we did previously.
> > > 
> > > Having a single feature bit makes it easier to distinguish between a
> > > traditional vhost-user device and a standalone device.
> > > 
> > > For example, the presence of VHOST_USER_F_GET_DEVICE_ID doesn't tell
> > > you whether this device is a standalone device that is appropriate for
> > > a new generic QEMU --device vhost-user-device feature that Alex is
> > > working on. It could be a traditional vhost-user device that is not
> > > standalone but implements the VHOST_USER_GET_DEVICE_ID message.
> > > 
> > > How will we detect standalone devices? It will be messy if there is no
> > > single feature bit that advertises that this back-end is a standalone
> > > device.
> > > 
> > > Stefan
> > 
> > Looks like standalone implies some 5-6 messages to be supported.
> > So just test the 6 bits are all ones.
> 
> It's not clear to me that the individual bits together mean this is
> really a standalone device, but let's go with individual commands and
> see if a front-end can distinguish standalone devices or not. If not,
> then we can still add "standalone" feature bit before merging the code.
> 
> Stefan


I think it just shows that what a "standalone" device is just isn't
that well defined ;).

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

