Return-Path: <virtio-dev-return-11310-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E442C64ED6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 08:35:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9B7942A81D
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 08:35:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 840A898644F
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 08:35:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 741C69863ED; Mon, 27 Feb 2023 08:35:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 59D3C9863F0
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Feb 2023 08:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: y6q-m56zPlSHovPdKmfRVA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmEV1tNjY8GWMhbj/5XRJP3BHocEfyfIFzTnEFQ5uCo=;
        b=u8OkTF7SNzmos0vAapc6HuWiehlx2nzdGFk4bYJ6llPktQYsFlSWTYBRoBijFjmkFE
         48P9lkwtRsE11JrOyoKZsSJoqHPzBleSPd/vk5cRjz9FJyH741iooq+lt6XBRlSYaLYY
         ClsIEuq3b0BPbUXcxRhzHf/etxdnoT3e7HS344M818R73NecIbaOBUGZ/5ua2+WP76Mm
         bDjH2iUQTL12ZKviXYITGyMfCO0wK7adUFSOKouDnRaJKsSYKsOhujc3Ln1iSGJjAg6x
         ScRVmZ1OBENxsHzFMd/vjI3tcggnWuLQ/tDaZdtmj9dea9FVpEL2/JJCop+o4RzfaUBi
         lsxQ==
X-Gm-Message-State: AO0yUKX5WS670/5QwwrTywg/nmnGVUqZY7FtT5errNjxyuHj3Q90qutW
	zgIigz0DJ9IVK2+2bZdFUIYInL9UC8vkaIY9JnhxBhsGgQGGreZ2clUnw+v5AOjBYkZe0976h25
	5qVtMK9aF6+eNoMdqAUrP2l1VeaSe32lmdefyxQmPzBQY
X-Received: by 2002:aca:d06:0:b0:383:fef9:6cac with SMTP id 6-20020aca0d06000000b00383fef96cacmr3140387oin.9.1677486920350;
        Mon, 27 Feb 2023 00:35:20 -0800 (PST)
X-Google-Smtp-Source: AK7set+QoD0VX417JDrZ66spsZyYSgympqjwlHnq7WMY0HFo7mHwFqLm30nJKZJ3ZsMXAL9pVPmQaVFsW+SS372uP1I=
X-Received: by 2002:aca:d06:0:b0:383:fef9:6cac with SMTP id
 6-20020aca0d06000000b00383fef96cacmr3140385oin.9.1677486920125; Mon, 27 Feb
 2023 00:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230221124518-mutt-send-email-mst@kernel.org> <4d123e32-1ad0-e692-7fa6-0565eb34c487@redhat.com>
 <0f53212f-a89b-ad3c-73e3-a7a7b5533058@linux.alibaba.com> <1047920c-5dd5-8f31-0c4c-a108f36155f8@redhat.com>
 <20230223075934-mutt-send-email-mst@kernel.org> <CACGkMEvc2Px_Zz11R5QYwMXYm_j5rsYV2LrZt5yf8tZQxuT_Bg@mail.gmail.com>
 <20230224030509-mutt-send-email-mst@kernel.org> <CACGkMEuOu=6qKQO2TJ0B6ZLRH_-rGtZMYVtw7gn+BFbnJgWkrw@mail.gmail.com>
 <20230227023657-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230227023657-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 27 Feb 2023 16:35:09 +0800
Message-ID: <CACGkMEtOFC-xygzgECi82j4Q6PacpjVnyPMs1Q6c9PN0RfX5bw@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230227083509.piiGFyPGrVnrnvOYcXpUFHlrTw0NSWF9TG1fvmUgYeE@z>

On Mon, Feb 27, 2023 at 3:39=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Mon, Feb 27, 2023 at 12:07:17PM +0800, Jason Wang wrote:
> > Btw, this kind of 1:1 hash features seems not scalable and flexible.
> > It requires an endless extension on bits/fields. Modern NICs allow the
> > user to customize the hash calculation, for virtio-net we can allow to
> > use eBPF program to classify the packets. It seems to be more flexible
> > and scalable and there's almost no maintain burden in the spec (only
> > bytecode is required, no need any fancy features/interactions like
> > maps), easy to be migrated etc.
> >
> > Prototype is also easy, tun/tap had an eBPF classifier for years.
> >
> > Thanks
>
> Yea BPF offload would be great to have. We have been discussing it for
> years though - security issues keep blocking it. *Maybe* it's finally
> going to be there but I'm not going to block this work waiting for BPF
> offload.  And easily migrated is what BPF is not.

Just to make sure we're at the same page. I meant to find a way to
allow the driver/user to fully customize what it wants to
hash/classify. Similar technologies which is based on private solution
has been used by some vendors, which allow user to customize the
classifier[1]

ePBF looks like a good open-source solution candidate for this (there
could be others). But there could be many kinds of eBPF programs that
could be offloaded. One famous one is XDP which requires many features
other than the bytecode/VM like map access, tailcall. Starting from
such a complicated type is hard. Instead, we can start from a simple
type, that is the eBPF classifier. All it needs is to pass the
bytecode to the device, the device can choose to run it or compile it
to what it can understand for classifying. We don't need maps, tail
calls and other features. We don't need to worry about the security
because of its simplicity: the eBPF program is only in charge of doing
classification, no other interactions with the driver and packet
modification is prohibited. The feature is limited only to the
VM/bytecode abstraction itself.

What's more, it's a good first step to achieve full eBPF offloading in
the future.

Thanks

[1] https://www.intel.com/content/www/us/en/architecture-and-technology/eth=
ernet/dynamic-device-personalization-brief.html

>
> --
> MST
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

