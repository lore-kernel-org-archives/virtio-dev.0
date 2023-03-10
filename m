Return-Path: <virtio-dev-return-11596-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF0BC64EC4
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 09:35:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8FCB12AD70
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 09:35:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8255B986728
	for <virtio-dev@archiver.kernel.org>; Fri, 10 Mar 2023 09:35:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 741F2986717; Fri, 10 Mar 2023 09:35:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4596C986718
	for <virtio-dev@lists.oasis-open.org>; Fri, 10 Mar 2023 09:34:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: CiUHlw57N2iAXHDigrYPOg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678440891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLHMD5ZXRbqYy9eEZmCJWU9/VAo9vc1q6KOPYRWiIuM=;
        b=hmBjahfc1KGHf8/pihymF2ECPiZnjL1VFDijJE2DDb9vqbHX+VcsEnH6qfAcgRzwI4
         cwEDXUqY4/OTDRTNrxUPwrmuZzsUiEKvToH78ZnZmkHzTw0KhxkZqLXTd9UVbAnw+SAT
         J2na6uk0f87BIHSoFtyeyG9Av0ekYT7T/cleqc/GjVOdH8oPp0fu7p2XMpclVQLfBeYo
         7sYpHwA5pgmx+M5YTIF1JxwhdEfdGsGTK+0NaiZ11XZpnY3ZaOD6ebezZ2U+Wc44MGoj
         LHTs7SROB4AQMEOrWywnhHU5W3qdPA93Luu6N4SpuianEBu/P68SxdeVSkb31Rn7oRI/
         dD8w==
X-Gm-Message-State: AO0yUKXU8xZtVy1gINrxNbm4XKdkIHqLxOXsymkSk4QiEreQrZDT8lI3
	BQZbBxFgLInWhX9gc43PE16ufeSx2f/JWlSc+8NpxNPyTJ8ppCGbZkRtQsqZsLoj0gmnGFdJquf
	fePtdAm7BAz7DAvNNXGP06G8jhDuI
X-Received: by 2002:adf:e6cc:0:b0:2ca:de61:b234 with SMTP id y12-20020adfe6cc000000b002cade61b234mr12468399wrm.51.1678440891346;
        Fri, 10 Mar 2023 01:34:51 -0800 (PST)
X-Google-Smtp-Source: AK7set+UJIj0pyEhEVP+6VFxuSq6m+d7yMAiJGD0iHNg0QuQVynLk2CZn/avrynf7J7KD9duS0N6hA==
X-Received: by 2002:adf:e6cc:0:b0:2ca:de61:b234 with SMTP id y12-20020adfe6cc000000b002cade61b234mr12468273wrm.51.1678440887238;
        Fri, 10 Mar 2023 01:34:47 -0800 (PST)
Date: Fri, 10 Mar 2023 04:34:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230310043230-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <6677477d48dfc234d3d1a339fb39d8fa2a3b983d.1677761896.git.mst@redhat.com>
 <f37a5993-1349-75ac-1928-beafa98fc068@intel.com>
MIME-Version: 1.0
In-Reply-To: <f37a5993-1349-75ac-1928-beafa98fc068@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 09/10] admin: conformance clauses

On Fri, Mar 10, 2023 at 05:10:48PM +0800, Zhu, Lingshan wrote:
> > +The list of supported commands MUST NOT shrink (but MAY expand):
> > +after reporting a given command as supported through
> > +VIRTIO_ADMIN_CMD_LIST_QUERY the device MUST NOT later report it
> > +as unsupported.  Further, after a given set of commands has been
> Can the driver re-negotiate the command list through QUERY/USE
> in flight rather than upon a reset? If not, shall forbid this explicitly?

Probably best to allow this.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

