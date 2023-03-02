Return-Path: <virtio-dev-return-11354-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD5EC6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 08:15:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A3B9D2AD5F
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 08:15:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 821A8986678
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 08:15:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6A35D983EB8; Thu,  2 Mar 2023 08:15:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 57B3E986674
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 08:15:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: c0PTrUKbNRWLJIcSj2N7Kg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3XtjKCeJx46eXrkNW69Ux+nxwzd274pgu/UvGUPU4k=;
        b=Pw5dtwnfqDrDOy/QgCwf1hHKwt0mZQ0fdk32vxzaoAiayT/TlXDxXAGvYPsS7ss9sj
         SJ0+mW9ZZpdPJPiwy/HJ5aLE5fftUoQ/Rcs0fgAHEwlX1LbigxMAgMV6T0V4LkSVr+8S
         E/aSdFSTSr2wItm1LpviPJ0gTE/nsTzo6VeO4SWylxlcRQQSIX9RgdVSOJvGGuci+rQ9
         90BWZbQS6HoP4wj54cc8XuVxUQuuXi2SQfQnCIDrL+khvkpY+apYDNzD8vgy5qdSLOMZ
         JRtGzD58uKT09YKGfGSL8TAFiO5r9kxntsM28B35fUjtZ31U2tHGgthOFeDeTyuRi7qP
         1xbg==
X-Gm-Message-State: AO0yUKVKFQJzaZvkm7AHC6sbWfHyExMetAaBb4/0flVjOHAJaQ8GHIwn
	DZZ951sED5dkJTeaNF7X1LqGKRnIU0LaJSipdYSlQgWA6qdontO4kz6uzzQTexxcuKab7Zqzyl4
	hSgJFxRpmrpPw9BhYQVaKxQYl6ePvKUsCVdVPz9xwWdne
X-Received: by 2002:a05:6870:b7b2:b0:172:3aea:ecaa with SMTP id ed50-20020a056870b7b200b001723aeaecaamr2831955oab.9.1677744950733;
        Thu, 02 Mar 2023 00:15:50 -0800 (PST)
X-Google-Smtp-Source: AK7set8Cp414VxIKNEBmpze6K0j3Jr5+OcRoRlGm/Zqah8sdYu8OmxxxtMTJ8IqAlqkGF0se0wOpEoQMgvqucI747G0=
X-Received: by 2002:a05:6870:b7b2:b0:172:3aea:ecaa with SMTP id
 ed50-20020a056870b7b200b001723aeaecaamr2831949oab.9.1677744950479; Thu, 02
 Mar 2023 00:15:50 -0800 (PST)
MIME-Version: 1.0
References: <20230227023657-mutt-send-email-mst@kernel.org>
 <CACGkMEtOFC-xygzgECi82j4Q6PacpjVnyPMs1Q6c9PN0RfX5bw@mail.gmail.com>
 <20230227124800-mutt-send-email-mst@kernel.org> <CACGkMEvUaQuzMx4iwkaYg9t9Bz2Ev0eHAwgrWbNEwtQHZOkkvQ@mail.gmail.com>
 <20230228060352-mutt-send-email-mst@kernel.org> <CACGkMEvAGABhk6JX7+F-sDtRM7t1oONEz9wrgKM7iShmyYV34A@mail.gmail.com>
 <20230301053407-mutt-send-email-mst@kernel.org> <CACGkMEsSCGo01WsLvDojB5s8yjqL1mV0s328DnssosnNO=4M4w@mail.gmail.com>
 <20230302024129-mutt-send-email-mst@kernel.org> <CACGkMEtLRhJ=4xiwRO96hb6HOdO8n1on62Gyu72aV6+MWag2jQ@mail.gmail.com>
 <20230302030935-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230302030935-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Mar 2023 16:15:39 +0800
Message-ID: <CACGkMEs6Bz-t0TPR9vqH+iVY-w7z72ii-nvX+YhQkHG5Z8yWTQ@mail.gmail.com>
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

On Thu, Mar 2, 2023 at 4:10=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Mar 02, 2023 at 03:57:10PM +0800, Jason Wang wrote:
> > Kernel had already used the eBPF program for hashing, classifying
> > various types of eBPF program other than XDP/socket filter
> > (pass/drop).
> >
> > Thanks
>
> where is it used for hashing?

I can see it is used by team/lb:

static unsigned int lb_get_skb_hash(struct lb_priv *lb_priv,
                                    struct sk_buff *skb)
{
        struct bpf_prog *fp;
        uint32_t lhash;
        unsigned char *c;

        fp =3D rcu_dereference_bh(lb_priv->fp);
        if (unlikely(!fp))
                return 0;
        lhash =3D bpf_prog_run(fp, skb);
        c =3D (char *) &lhash;
        return c[0] ^ c[1] ^ c[2] ^ c[3];
}

But the point is that the return value is determined by the prog type
(or the context).

Thanks

>
> --
> MST
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

