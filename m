Return-Path: <virtio-dev-return-11482-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C02C6FD1A
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 16:14:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DE7364434B
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 16:14:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE26C9866D1
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 16:14:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C18699866C6; Tue,  7 Mar 2023 16:14:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B163B9866C7
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Mar 2023 16:14:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: wzFi4VCvP7yRA-XmUTO6kg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678205586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/ZiGnvwnABySinijQZzMTBCynCMdOabHec33IXZr+g=;
        b=wkchNrg3Ig7FIx9gVbfOHqa5Hq8/cyKIOeQ8rTcmzccBb9ucsVkW3tFxftTQ6drVuJ
         rbnFF0+LZ+h99EEzm3/GzWFS2aZ/xUUl8evrohlyzL8HWrsCSzkxXsKEDV5/zentkJdY
         Jn0PABAaSI41DrY8wGw3oZGYGqwPgEuhfsJf2BhKUsbFwyc2v8rCIxX7mrjwswvJ5/k+
         /RDRHKjUVGBIRd0h6ok1zhLiYinFlYPV3QU/c2nTknjUkjZQv1menc7V43UwgxB/wd1F
         BecSXxOsz6odOTwnwAMTXdQ8TNDcoVtHW/w5FEcvVZXRFJ3H/e+LrNgNQD8/s2GNQmsA
         CPSg==
X-Gm-Message-State: AO0yUKVFbntzwqTRVxs0kHsg3P5lI/3Hamo4z1FJV5JThuP12GbhkEyK
	dk+Qa1ksEUC4N9Ctp6bbLBfAtWAxw9JWFvaa8HoGOSHJQ0PMqhI4VpyGISFl4mzNQcfU+6M8SRc
	R5jspBzXc1tCuy07EmyiOySDRBksT
X-Received: by 2002:a05:600c:3552:b0:3eb:3692:644d with SMTP id i18-20020a05600c355200b003eb3692644dmr13530831wmq.22.1678205586279;
        Tue, 07 Mar 2023 08:13:06 -0800 (PST)
X-Google-Smtp-Source: AK7set/RXaMK1doVkCadLKks1BW4lU+ILtQjeV3PlfLSIkSaJGIpkxtBdWFEb74m+oj0XA5eEU3gRg==
X-Received: by 2002:a05:600c:3552:b0:3eb:3692:644d with SMTP id i18-20020a05600c355200b003eb3692644dmr13530809wmq.22.1678205586012;
        Tue, 07 Mar 2023 08:13:06 -0800 (PST)
Date: Tue, 7 Mar 2023 11:13:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, jasowang@redhat.com,
	cohuck@redhat.com, sgarzare@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230307111143-mutt-send-email-mst@kernel.org>
References: <20230302190230-mutt-send-email-mst@kernel.org>
 <20230303132840.GC2866370@fedora>
 <20230303083213-mutt-send-email-mst@kernel.org>
 <20230303202133.GA2901137@fedora>
 <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <20230305191351-mutt-send-email-mst@kernel.org>
 <20230306110340.GA35392@fedora>
 <20230306133525-mutt-send-email-mst@kernel.org>
 <ZAbvxj+7lgaI1HkI@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <ZAbvxj+7lgaI1HkI@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues

On Tue, Mar 07, 2023 at 09:03:18AM +0100, Jiri Pirko wrote:
> I sense there is no concete idea about what the "admin virtqueue" should
> serve for exactly.

Because the virtqueue is just a virtqueue - a way to pass around
commands.  Admin commands are used whenever one needs to talk to one
device about another one.
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

