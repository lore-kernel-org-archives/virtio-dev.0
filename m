Return-Path: <virtio-dev-return-12056-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0E2C76196
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:13:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1D44B3358D
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:13:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 104159865EC
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 11:13:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 05ED39865D9; Fri,  7 Apr 2023 11:13:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E7C8E9865D8
	for <virtio-dev@lists.oasis-open.org>; Fri,  7 Apr 2023 11:13:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: gECfLG1MPVu6GIUXRhGfdQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680865999;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3LFma+lRqmDSh9PxnvYBSCbMmX2XoqjUoTkkwwT28A=;
        b=keGD64MYHKwPisHJ6BWRCrE8ASdoH8BaRZud+ApFolpzu3yjYenMJP0WjQXS5+PurB
         njidZfsWJy5yfMi8SlAyuLUUro6xzgX0/mzwqQxTvpKX5wzwrau4tULasgeu53jUTKbS
         mjCGBnpcuqc70Pbjoltu1ygah6Lg7w/gZqm1k+qZHdYdqJPQUuYJu14URNB3byF4o2od
         dooxawe+Oq/6VNmru+iQs+NtRM/+XA197hMfbJCiheoWPvoCbOzXB18OlDfLg+3AqCw2
         edHDHzkxBD5Mt5Y/2MthCijv+AtsgiVqNpf6CE4pQlco38Vnaco5hq+W6gHaohbJHf2/
         Ib1w==
X-Gm-Message-State: AAQBX9d1gA/niO9LzD93VpcHystoMju9F/pBkCWlyb6eY1YtdhR7GUJ8
	7a1YaGcjTjJk4A7LB1w2q2ISE4NMHBfq6TRkZfMVcflVb4Bzp2TTYls2TW/bF6SvhYr/UYdFzhs
	B78EIDRwJki+wqkUr6HTVPCyDSPPp
X-Received: by 2002:adf:df0b:0:b0:2ef:b139:5973 with SMTP id y11-20020adfdf0b000000b002efb1395973mr1048918wrl.17.1680865998881;
        Fri, 07 Apr 2023 04:13:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y1D5XyEBhaTjnWjn8ODLM2+ZhEW/9dJ/g2z84v/8imAJMUaNOuYt1mzrzwBQ0htzHvpcsSqw==
X-Received: by 2002:adf:df0b:0:b0:2ef:b139:5973 with SMTP id y11-20020adfdf0b000000b002efb1395973mr1048887wrl.17.1680865998594;
        Fri, 07 Apr 2023 04:13:18 -0700 (PDT)
Date: Fri, 7 Apr 2023 07:13:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Wen Gu <guwen@linux.alibaba.com>, Halil Pasic <pasic@linux.ibm.com>,
	virtio-comment@lists.oasis-open.org, hans@linux.alibaba.com,
	herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com,
	dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
	zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com,
	gerry@linux.alibaba.com, cohuck@redhat.com, jasowang@redhat.com,
	Jan Kiszka <jan.kiszka@siemens.com>, kgraul@linux.ibm.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, hca@linux.ibm.com,
	twinkler@linux.ibm.com, raspl@linux.ibm.com,
	virtio-dev@lists.oasis-open.org,
	Alexandra Winter <wintera@linux.ibm.com>
Message-ID: <20230407070820-mutt-send-email-mst@kernel.org>
References: <20230209033056.96657-1-xuanzhuo@linux.alibaba.com>
 <20230209033056.96657-2-xuanzhuo@linux.alibaba.com>
 <20230323154656.7f036d52.pasic@linux.ibm.com>
 <ff9b28a1-e0ee-f082-1f40-f3e149c9403e@linux.alibaba.com>
 <7a9ebec0-5e87-b80f-4f2c-c4db7ae4fe84@linux.ibm.com>
 <20230405084632-mutt-send-email-mst@kernel.org>
 <1680837735.392044-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1680837735.392044-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [PATCH v3
 1/1] virtio-ism: introduce new device virtio-ism

On Fri, Apr 07, 2023 at 11:22:15AM +0800, Xuan Zhuo wrote:
> On Wed, 5 Apr 2023 08:52:14 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Apr 05, 2023 at 02:39:53PM +0200, Alexandra Winter wrote:
> > >
> > >
> > > On 24.03.23 05:03, Wen Gu wrote:
> > > >
> > > >
> > > > On 2023/3/23 22:46, Halil Pasic wrote:
> > > >
> > > >> On Thu,  9 Feb 2023 11:30:56 +0800
> > > >> Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > >>
> > >
> > > ...
> > >
> > > >
> > > >> To get back to the things proposed here: the cdid is IMHO
> > > >> a nice thing, and is functionally corresponding to the
> > > >> (S)EID. But it is 16 byte wide, and I have no idea how
> > > >> is it supposed to be used in the CLC handshake.
> > > >>
> > > >
> > > > CLC handshake carry one SEID for all the SMC-D device. Considering
> > > > coexistence with ISM, I am not sure whether we can change or increase
> > > > the SEID.. cc Alexandra
> > > >
> > > > Thanks!
> > > > Wen Gu
> > >
> > > As mentioned by others, discussions are ongoing.
> > > It would be great, if we can agree on a way to use the existing CLC handshake
> > > for SMC-D via virtio-ism and ism-loopback.
> > > In that case SEID needs to be unique per hardware instance, cannot be increased and
> > > can only be changed for x86 in a non-colliding way.
> > >
> > > An alternative would be to define new a SMC-D(?) protocol variant/version, where we
> > > are free to define new fields (e.g. UUIDs).
> > >
> > > Alexandra
> >
> > Problem with tying to hardware is that it is blocking
> > migration (which is a challenge with ism anyway, but still).
> 
> 
> We don't want to support migration. At least we don't want to support it for the
> time being. Because there are indeed many problems. I think Migration is not
> necessary for a new Virtio device.
> 
> Thanks.

The specific implementation does not matter much. At the spec level we
strive to make interfaces generic so they can be reused down the road,
rather than having to invent new ones for each use-case.
Maybe we can come up with a way that let devices choose either
an existing one with a SEID or a new one with a UUID?


-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

