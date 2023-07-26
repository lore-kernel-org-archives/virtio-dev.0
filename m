Return-Path: <virtio-dev-return-13411-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61D8C001DF
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Jul 2023 16:01:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 22CCD2B028
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Jul 2023 16:01:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0FDE19866C4
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Jul 2023 16:01:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ECC639866BE; Wed, 26 Jul 2023 16:01:19 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D8EA89866BF
	for <virtio-dev@lists.oasis-open.org>; Wed, 26 Jul 2023 16:01:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: PgSqdVU6MoW2ewWfOekZRw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690387272; x=1690992072;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AhY1Hs7QOV6A70CnYUt6ytS3aAg6p7aC6MnWNaWl6HI=;
        b=QHRazLVQHuw5ZH6imNGHI0indHkarQndjmFHh9giWOTRL9nrS1VssphZwVYBlFyJmx
         oagiKH4xQOgUb8df7+tqMNVoPKYvHvc+QajdHGKbZz54IvI1lIGbOmpdLPr2qoAnMFac
         gDb7ZXkpV90glkK8LAzFii4yVwa+r8iQ7V/MbtJ+I+fuOYCRzr/T0v6Y7YKVbOnnhqQR
         cuAubJP4S33i7C2I/AE/Nk/ofh0lVPVgG9RvK0TgjJ2LI7Yby1aUPoEZuS+8pAvsR/BU
         odafgfGYW2cKUmD8lPz3OHc+t8tLMHAAp+rwRgNOBruSvpSQqoIjkLkSfetcyFGMHvSJ
         zOoA==
X-Gm-Message-State: ABy/qLaCqnL9czD3EqFWpE0ZVV6vXltlPANm4tEwXVzkM0XFgh/OnqE5
	Xwp3X4Vtejd0XEwt+IYdPDAiUFAEP/I33o9XBMNULubonKWX/qHkSQUGgw1DBJNUJ3V3YoupONL
	buKPRWXda0uer+z4Tp+6UeFDtQX6Y
X-Received: by 2002:a17:906:6495:b0:977:e310:1ce7 with SMTP id e21-20020a170906649500b00977e3101ce7mr2239638ejm.38.1690387272806;
        Wed, 26 Jul 2023 09:01:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG1L+AG4ddmpoqNyrxJMl0PWlzoUaXUY6KXA4UGwKS/61jEW0cDEnSsh6rhCfqHmaoIX95XJg==
X-Received: by 2002:a17:906:6495:b0:977:e310:1ce7 with SMTP id e21-20020a170906649500b00977e3101ce7mr2239613ejm.38.1690387272455;
        Wed, 26 Jul 2023 09:01:12 -0700 (PDT)
Date: Wed, 26 Jul 2023 12:01:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org,
	slp@redhat.com, marcandre.lureau@redhat.com,
	viresh.kumar@linaro.org, takahiro.akashi@linaro.org,
	erik.schilling@linaro.org, manos.pitsidianakis@linaro.org,
	mathieu.poirier@linaro.org
Message-ID: <20230726120004-mutt-send-email-mst@kernel.org>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <3ogh7u3ezp7vlrp3ticquoajgsnpnglplm44osrsd7gvxv2lyn@g22qgf4vwgp5>
 <87o7krg0sn.fsf@linaro.org>
 <qmwvywoy7lfkgr7kcc6cxghulgd5g2gvnv76mvkuxbqclbwmti@4qyiktfiu2ej>
 <20230720193601.GI210977@fedora>
MIME-Version: 1.0
In-Reply-To: <20230720193601.GI210977@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [RFC PATCH] docs/interop: define STANDALONE
 protocol feature for vhost-user

On Thu, Jul 20, 2023 at 03:36:01PM -0400, Stefan Hajnoczi wrote:
> On Fri, Jul 07, 2023 at 12:27:39PM +0200, Stefano Garzarella wrote:
> > On Tue, Jul 04, 2023 at 04:02:42PM +0100, Alex Bennée wrote:
> > > 
> > > Stefano Garzarella <sgarzare@redhat.com> writes:
> > > 
> > > > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Bennée wrote:
> > > > > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> > > > > index 5a070adbc1..85b1b1583a 100644
> > > > > --- a/docs/interop/vhost-user.rst
> > > > > +++ b/docs/interop/vhost-user.rst
> > > > > @@ -275,6 +275,21 @@ Inflight description
> > > > > 
> > > > > :queue size: a 16-bit size of virtqueues
> > > > > 
> > > > > +Backend specifications
> > > > > +^^^^^^^^^^^^^^^^^^^^^^
> > > > > +
> > > > > ++-----------+-------------+------------+------------+
> > > > > +| device id | config size |   min_vqs  |   max_vqs  |
> > > > > ++-----------+-------------+------------+------------+
> > > > > +
> > > > > +:device id: a 32-bit value holding the VirtIO device ID
> > > > > +
> > > > > +:config size: a 32-bit value holding the config size (see ``VHOST_USER_GET_CONFIG``)
> > > > > +
> > > > > +:min_vqs: a 32-bit value holding the minimum number of vqs supported
> > > > 
> > > > Why do we need the minimum?
> > > 
> > > We need to know the minimum number because some devices have fixed VQs
> > > that must be present.
> > 
> > But does QEMU need to know this?
> > 
> > Or is it okay that the driver will then fail in the guest if there
> > are not the right number of queues?
> 
> I don't understand why min_vqs is needed either. It's not the
> front-end's job to ensure that the device will be used properly. A
> spec-compliant driver will work with a spec-compliant device, so it's
> not clear why the front-end needs this information.
> 
> Stefan



I think this really demonstrates why we should keep separate
messages and not the "standalone" thing which seems to
mean "bundle a bunch of mostly unrelated stuff in one message":
this way each field is carefully documented.


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

