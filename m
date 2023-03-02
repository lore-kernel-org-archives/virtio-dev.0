Return-Path: <virtio-dev-return-11357-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A153C6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 09:00:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 354912B054
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 09:00:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0BF28986686
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 09:00:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DC6BB986672; Thu,  2 Mar 2023 09:00:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9B5B986674
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 09:00:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: PV6MH9bIOwOXWUo2oYAwEg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9Ht4MvgE2mJqsegJnExnvEdT1Hlp0Gg/SOPEGHroL0=;
        b=R1f7a01g6wihfsSEcrbMY3juv10P92qb+7gM2ityUyDveEwx0G6tu2q/lWJFiFnj/N
         tx3aGhonWQgHGdu9PMeWGJFNpiJga+vu+5lu35jTASYCyDHx7RVXbSCg6mZEHVhlhZn3
         fafcqwz2+YHmB4sPsfyeQwFUhhppMRLVuPgeS2HAMICZrDgASD1X8UNmYE7oAWG904Jh
         yOzi+ZHRwVqIsQd3VLfUmCRtSV/WMdPm5x3qB1GkGXdkNDUvPxlzBOEwQJipY/pWQCVh
         O4GtvsaNRtMFDK5L5QyzoqGtSnh/UeO2ymAZ57eYSihqlSn84udXiCN8TH+Ew1EcYfDw
         hH5w==
X-Gm-Message-State: AO0yUKX25VPrcQnzTnbHdUvuHbSyMQhrX/lG4ntCFkeFHloVIbtwBjWu
	E6qMvkZmDAInl+N8lAtDu/Tniz2ChpXAorGcTi2hEV0YFTAm7wZ0GQP9UNg2EcIzo/KSUf5QDCt
	tarSJHxeGx8UoiODFXFwGrHMj+e1airEKF/ffus4ne2jp
X-Received: by 2002:a05:6808:206:b0:384:c4a:1b49 with SMTP id l6-20020a056808020600b003840c4a1b49mr2931677oie.9.1677747598205;
        Thu, 02 Mar 2023 00:59:58 -0800 (PST)
X-Google-Smtp-Source: AK7set8d8LlsQHHooYS4cXX3X+ylpVs3PIcsx6tA631B9KVndV4gqEgLycfMG3oC/8y+rwyozLha3RDlU+7HHlFp5ec=
X-Received: by 2002:a05:6808:206:b0:384:c4a:1b49 with SMTP id
 l6-20020a056808020600b003840c4a1b49mr2931667oie.9.1677747598015; Thu, 02 Mar
 2023 00:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20230227124800-mutt-send-email-mst@kernel.org>
 <CACGkMEvUaQuzMx4iwkaYg9t9Bz2Ev0eHAwgrWbNEwtQHZOkkvQ@mail.gmail.com>
 <20230228060352-mutt-send-email-mst@kernel.org> <CACGkMEvAGABhk6JX7+F-sDtRM7t1oONEz9wrgKM7iShmyYV34A@mail.gmail.com>
 <20230301053407-mutt-send-email-mst@kernel.org> <CACGkMEsSCGo01WsLvDojB5s8yjqL1mV0s328DnssosnNO=4M4w@mail.gmail.com>
 <20230302024129-mutt-send-email-mst@kernel.org> <CACGkMEtLRhJ=4xiwRO96hb6HOdO8n1on62Gyu72aV6+MWag2jQ@mail.gmail.com>
 <20230302030935-mutt-send-email-mst@kernel.org> <CACGkMEs6Bz-t0TPR9vqH+iVY-w7z72ii-nvX+YhQkHG5Z8yWTQ@mail.gmail.com>
 <20230302033958-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230302033958-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Mar 2023 16:59:46 +0800
Message-ID: <CACGkMEvNXaA0uTffiQaDL311En-L4MYJpdOZDMX4EQ4QpQvj2w@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash

On Thu, Mar 2, 2023 at 4:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Mar 02, 2023 at 04:15:39PM +0800, Jason Wang wrote:
> > On Thu, Mar 2, 2023 at 4:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Thu, Mar 02, 2023 at 03:57:10PM +0800, Jason Wang wrote:
> > > > Kernel had already used the eBPF program for hashing, classifying
> > > > various types of eBPF program other than XDP/socket filter
> > > > (pass/drop).
> > > >
> > > > Thanks
> > >
> > > where is it used for hashing?
> >
> > I can see it is used by team/lb:
> >
> > static unsigned int lb_get_skb_hash(struct lb_priv *lb_priv,
> >                                     struct sk_buff *skb)
> > {
> >         struct bpf_prog *fp;
> >         uint32_t lhash;
> >         unsigned char *c;
> >
> >         fp =3D rcu_dereference_bh(lb_priv->fp);
> >         if (unlikely(!fp))
> >                 return 0;
> >         lhash =3D bpf_prog_run(fp, skb);
> >         c =3D (char *) &lhash;
> >         return c[0] ^ c[1] ^ c[2] ^ c[3];
> > }
> >
> > But the point is that the return value is determined by the prog type
> > (or the context).
> >
> > Thanks
>
> OK so assuming we do this, how will users program this exactly?

For DPDK users, it could be integrated with the PMD.
For kernel ueres, it probably requires a virtio specific netlink or char de=
vice.

> Given this is not standard, which tools will be used to attach such
> a program to the device?

vDPA tool?

Thanks

>
>
> > >
> > > --
> > > MST
> > >
> > >
> > > ---------------------------------------------------------------------
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

