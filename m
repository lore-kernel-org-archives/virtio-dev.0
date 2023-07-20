Return-Path: <virtio-dev-return-13396-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A74EB64DA
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 22:22:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 63445444C
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 22:22:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B3B8986837
	for <virtio-dev@archiver.kernel.org>; Thu, 20 Jul 2023 22:22:17 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1E4B0983D01; Thu, 20 Jul 2023 22:22:17 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0AEB3986835
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Jul 2023 22:22:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: cuLGB1N2ML-rJbsr2_jCZg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689891733; x=1690496533;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/5ZSWgQ7hYPT6II/PNiOy01U/I9L4WpoP4ciI4EhJlU=;
        b=kS1PZ1uRizRlQrXXNe99vpBm5vJcaKL6GFUeE0ve6WNRJmOCQHwbVSVvL2V9OrFyvy
         wZszLFI8GPsLnJg4KIwib4nMuiNlzOkgefnFpjPKSF3HGnuRRCIH83CcKbWMv3UCdIbB
         F/dM90V1d8R8thm5YzMd7wVTOzRPxpYbXM7mn/6/MWSAXDY7FNujvcVX2T2LIPgRT3fC
         JwdoU9e5Vs/KJDR9X4FuMwTzlzs8guvgk49PHUh6HjYVWmUYM0MDE5tptq8MHjY8KNTf
         DrSC9SkT8TzaCLYPwU9eRoAPM8qHa4jOwffC84Csxn7Et+1RyD1M6H3X7E4PVBe43k+T
         vN5A==
X-Gm-Message-State: ABy/qLay14KPuxs42GYF4gNAIa/tQu3LO3HRWdS3wL67Yv0EpCUz/fH0
	lpwYbsEZVyLPIh6HvBdmjY07FZNBqY9OpLu2B9U5jqPOzcTnBsSiokLLOYyrZCuG+gc5g6JL6N9
	4BhoUuaQ3PuddTlEvadNTWYW1gTFs
X-Received: by 2002:a2e:7813:0:b0:2b0:297c:cbdf with SMTP id t19-20020a2e7813000000b002b0297ccbdfmr214458ljc.1.1689891733055;
        Thu, 20 Jul 2023 15:22:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH3KHrbBmUCxPgfPpbLxqktxIENvAldsQp/fzQUmaan/5XD49H+rZTOplA2Kz67oIrPn2OCTQ==
X-Received: by 2002:a2e:7813:0:b0:2b0:297c:cbdf with SMTP id t19-20020a2e7813000000b002b0297ccbdfmr214436ljc.1.1689891732691;
        Thu, 20 Jul 2023 15:22:12 -0700 (PDT)
Date: Thu, 20 Jul 2023 18:22:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
	slp@redhat.com, marcandre.lureau@redhat.com,
	viresh.kumar@linaro.org, sgarzare@redhat.com,
	takahiro.akashi@linaro.org, erik.schilling@linaro.org,
	manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Message-ID: <20230720182128-mutt-send-email-mst@kernel.org>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
 <20230720195837.GJ210977@fedora>
 <20230720171321-mutt-send-email-mst@kernel.org>
 <CAJSP0QVDBA0Fb+LVjJVWq7Dp7FosXAJsRJUCcAtdNr-VyzYipg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QVDBA0Fb+LVjJVWq7Dp7FosXAJsRJUCcAtdNr-VyzYipg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user

On Thu, Jul 20, 2023 at 05:31:03PM -0400, Stefan Hajnoczi wrote:
> On Thu, 20 Jul 2023 at 17:15, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jul 20, 2023 at 03:58:37PM -0400, Stefan Hajnoczi wrote:
> > > On Thu, Jul 06, 2023 at 12:48:20PM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Bennée wrote:
> > > > > Currently QEMU has to know some details about the back-end to be able
> > > > > to setup the guest. While various parts of the setup can be delegated
> > > > > to the backend (for example config handling) this is a very piecemeal
> > > > > approach.
> > > >
> > > > > This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
> > > > > which the back-end can advertise which allows a probe message to be
> > > > > sent to get all the details QEMU needs to know in one message.
> > > >
> > > > The reason we do piecemeal is that these existing pieces can be reused
> > > > as others evolve or fall by wayside.
> > > >
> > > > For example, I can think of instances where you want to connect
> > > > specifically to e.g. networking backend, and specify it
> > > > on command line. Reasons could be many, e.g. for debugging,
> > > > or to prevent connecting to wrong device on wrong channel
> > > > (kind of like type safety).
> > > >
> > > > What is the reason to have 1 message? startup latency?
> > > > How about we allow pipelining several messages then?
> > > > Will be easier.
> > >
> > > This flag effectively says that the back-end is a full VIRTIO device
> > > with a Device Status Register, Configuration Space, Virtqueues, the
> > > device type, etc. This is different from previous vhost-user devices
> > > which sometimes just offloaded certain virtqueues without providing the
> > > full VIRTIO device (parts were emulated in the VMM).
> > >
> > > So for example, a vhost-user-net device does not support the controlq.
> > > Alex's "standalone" device is a mode where the vhost-user protocol is
> > > used but the back-end must implement a full virtio-net device.
> > > Standalone devices are like vDPA device in this respect.
> > >
> > > I think it is important to have a protocol feature bit that advertises
> > > that this is a standalone device, since the semantics are different for
> > > traditional vhost-user-net devices.
> >
> > Not sure what that would gain as compared to a feature bit per
> > message as we did previously.
> 
> Having a single feature bit makes it easier to distinguish between a
> traditional vhost-user device and a standalone device.
> 
> For example, the presence of VHOST_USER_F_GET_DEVICE_ID doesn't tell
> you whether this device is a standalone device that is appropriate for
> a new generic QEMU --device vhost-user-device feature that Alex is
> working on. It could be a traditional vhost-user device that is not
> standalone but implements the VHOST_USER_GET_DEVICE_ID message.
> 
> How will we detect standalone devices? It will be messy if there is no
> single feature bit that advertises that this back-end is a standalone
> device.
> 
> Stefan

Looks like standalone implies some 5-6 messages to be supported.
So just test the 6 bits are all ones.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

