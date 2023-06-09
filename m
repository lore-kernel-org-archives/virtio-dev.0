Return-Path: <virtio-dev-return-12916-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3EFC7EE2E
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 03:03:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5C6AE1FF88
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 03:03:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 197D09867F9
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 03:03:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0517C98668D; Fri,  9 Jun 2023 03:03:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DFC0D986846
	for <virtio-dev@lists.oasis-open.org>; Fri,  9 Jun 2023 03:03:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: snjDii66N_2f2SRh8PdxUA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686279786; x=1688871786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlzRWEgocnUD7hpoxTTGuAzWyBFQaG4YbK7vQK4ykgc=;
        b=NR21MLAypwTJQ1uU8zN/RvaYnQ8qOhuuyWE8bmbEVWdbGtwpyt2jdL5Jd5Y6/PkRhM
         CQczBzngC7lhRih7Q8pCZnLAyC7hBJi4/4TH++0JpKs/OWtcFp71LHCy2qneKRg+GJw/
         zLyy+wvv5D1KOoReovWLM0MyqHoNghM2q16gbJGNhG4lNFPAISi6wgJ9E7Eq3qoQj4yC
         CtPsFwLkdse5oScGnbuQ0XyTwUUd4dtsbZx5TZeuBGb6BoDyeCPJXdUYHx0sd4Fp9uV5
         YRzPRQGhQ7WUB9uhyblWiBciQlhAzOB/HUND4agpj+MglSmGKiXMgjzVvNbRh6ZXDsfY
         +pdQ==
X-Gm-Message-State: AC+VfDzsUSDtid0p1GjjGAaK13h/jfObw2M5LxgAdReUu/u5OJhxyIgR
	vT0Y3bbrdMD7Va/i9SC9fF3urelX/JkWMDcN5enXPVKXh9ZDJMtY94aN5jf1AGssWPHbkxUqSdQ
	Xk0LrJpTjafFdg5ZD7cby9ZNFj3poHJ/hnzko2U0UUNrd
X-Received: by 2002:a2e:9d92:0:b0:2b1:ea42:6d26 with SMTP id c18-20020a2e9d92000000b002b1ea426d26mr186152ljj.18.1686279785792;
        Thu, 08 Jun 2023 20:03:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5mPjVASDKseT2zxi62UBkJHYM2xdPK4mTCT1INWcPhEDR01wFNB8/BkdW/BEhvaH2b369W0oc31rTt0CKvI0Q=
X-Received: by 2002:a2e:9d92:0:b0:2b1:ea42:6d26 with SMTP id
 c18-20020a2e9d92000000b002b1ea426d26mr186143ljj.18.1686279785503; Thu, 08 Jun
 2023 20:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230604105027-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174224-mutt-send-email-mst@kernel.org> <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605014539-mutt-send-email-mst@kernel.org> <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605092859-mutt-send-email-mst@kernel.org> <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org> <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org> <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsy=pG=LT0hOT-PO3HTkk3NOAu6qA_GaZpKwqq8B996cA@mail.gmail.com>
 <PH0PR12MB5481B197049376E7C4D0112EDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsPjwgx=atOC1ww+RnfJcrg7m2CmMXWQCCoreCwsWVpLg@mail.gmail.com>
 <PH0PR12MB54817C027CB2B7BB74BD35EDDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsGA4ZhOPn5OCTZEZkja2UrLpJ8DXH+d62Fp5rtdicseg@mail.gmail.com> <PH0PR12MB5481F1BE96B1CE71F4FBD2D8DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481F1BE96B1CE71F4FBD2D8DC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 9 Jun 2023 11:02:54 +0800
Message-ID: <CACGkMEu+LDKUkg5ZZjcRsztrL1QGY2a6wto8r93Ddwc6L=a63w@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [PATCH v3 0/3]
 transport-pci: Introduce legacy registers access using AQ

On Fri, Jun 9, 2023 at 10:58=E2=80=AFAM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Jason Wang
> > Sent: Thursday, June 8, 2023 10:57 PM
>
> > > > In order to converge the discussion, maybe you can explain which on=
e
> > > > of your 3 use cases and why can't work with _F_LEGACY_HEADER +
> > _F_LEGACY_MAC.
> > > Hypervisor does not involve in feature negotiation and device life cy=
cle phase
> > so it cannot negotiate it.
> >
> > With  _F_LEGACY_HEADER + _F_LEGACY_MAC, hypervisor doesn't need to be
> > involved in the feature negotiation for modern devices as well.
> >
> Guest does not have this feature negotiation driver.
> Hypervisor is not involved.
> So, who negotiates?

When legacy drivers are doing feature negotiation, the hypervisor must
trap and negotiate those two features.
When modern drivers are doing the feature negotiation, the hypervisor
is not involved at all. So modern drivers can choose to negotiate (e.g
try to mediate legacy for L2) or not.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

