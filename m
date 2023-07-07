Return-Path: <virtio-dev-return-13305-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B76EB64DA
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 08:29:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D788C2A8FF
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 08:29:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF0C8986811
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Jul 2023 08:29:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C1E93984091; Fri,  7 Jul 2023 08:29:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B05869867EB
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Jul 2023 08:29:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: -EqHARbYMrCCsN5uF45-0g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688718587; x=1691310587;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1ONV1iBQfRepNjPPZIvUNChwBnLdd4p40ttUkcv9vw=;
        b=F8gt8t+MQ5/CLvXpnTPqxriMcDWHRxxdn2OL73GbfJ30m2Tu3VQVsvUz2DEW+ARO3X
         28fWcUAHAPPgG0HoXgudkkirz3yKVIpjDM81YV7LvfNStzjlW9enkHNw8JDNtJLO4ife
         jcF679TBczh9MjnMZN0CG6w3UESzLWEQq64lB0T8XXdnOTkmQPJJVIZOOdBPuneIU7LK
         srmmEYfo6bjmlyKc4JOJiPKtkTV55W8cw8/M3i9IIJR+jm3xZe1AEndG5AF8bCWiuqz7
         SCZQXd7AkCS8/sRI0091hmWGo+zNZ+8fWxCKU7Eg/TM0Nv+feYnWXdRjF+4/g/kp05Xi
         wrxg==
X-Gm-Message-State: ABy/qLafYycWVAKjVDwcOI+Zpid4DeP5SJZYbBjEv0wraFepJq0UQGQ1
	221WsRdik2zx5mMkXSdWUsy3zjjYYJCj/H2GZsJ3xdLjnnQ8qgsUk8wnNEwVCENVC521klb/at0
	/hehHVQ96+z1zyzFUkqqWjBgbzT0a
X-Received: by 2002:a5d:5087:0:b0:30a:f030:8637 with SMTP id a7-20020a5d5087000000b0030af0308637mr3437059wrt.22.1688718587083;
        Fri, 07 Jul 2023 01:29:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEDS7CtZMOY+EWN1Ut01HOg4cK6yP/BWfvzU7QoGAMgh1JkD8krDHmDfrQg7kw6eNH+XLYEig==
X-Received: by 2002:a5d:5087:0:b0:30a:f030:8637 with SMTP id a7-20020a5d5087000000b0030af0308637mr3437042wrt.22.1688718586708;
        Fri, 07 Jul 2023 01:29:46 -0700 (PDT)
Date: Fri, 7 Jul 2023 04:29:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230707042905-mutt-send-email-mst@kernel.org>
References: <20230706212722.97973-1-parav@nvidia.com>
 <20230706212722.97973-4-parav@nvidia.com>
 <20230706174904-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DF6CC374634FE1A1AAF9DC2DA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481DF6CC374634FE1A1AAF9DC2DA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v11 3/3] admin: Add group member legacy register access
 commands

On Fri, Jul 07, 2023 at 03:54:31AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, July 6, 2023 6:36 PM
> 
> [..]
> 
> > I notice you decided to silently ignore my suggestion to document how are
> > notifications performed. Repeating myself like this is despiriting for me.
> I am sorry if it appeared that way,
> But no, I didn’t silently ignored.
> 
> I added the description as best I could find it, but you commented about it being messy with mixing up the terminology.
> I rewrote it in v12, it looks better now. Please check.
> 
> > Pls re-add especially since you already document it for the cfg_Write access
> > method anyway.
> > 
> Added without citation to hypervisor etc.
> 
> > 
> > also in a conformance section, document the effect of notification being the
> > same as notification through legacy interface.
> 
> PCI specific things were copied from the current spec reference in the notification capability section.
> All the changes you suggested are done.
> Captured in the change log of v12.
> 
> Thanks a lot.
> Since many parts are rewritten as you suggested in the thread, 
> I prefer to add your Signed-off to in v13 if we need roll it or when it is merged, please apply if you find it appropriate.
> It is at least important to me to add it yours Sign-off.

If you like sure.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

