Return-Path: <virtio-dev-return-12014-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BD4C7619A
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 10:26:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3570C2B056
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 10:26:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 122BA9865A8
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 10:26:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 00932983DE1; Wed,  5 Apr 2023 10:26:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2CAF9865A7
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Apr 2023 10:26:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680690413;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lww6dDMe0bMEJli6/6ZP6j4C+of80/qR+ErByK0yw5g=;
        b=jVTRrEgkuykMvmHwmq8VnlHBT5UQkiOKuPKOevJ4eHDYhHS/MKnWs6uNwGmJwSTeLM
         y8PH5kpnYArV/IpSoJ5sNcyNDS7ohOxVTDiPWaCRNpDviV6E+wNJnBPM0l4IaFEO80KF
         Uu/Qo5rXpkSbbzesV4NzCQRg4MPxRBBRK8p1fZnEGfOCejNKJNfQ+cgyJ9OkePqjz5Nu
         gk43xu0TCuPZI6idNta0/eUmRLepg3sA7JOMK2Y5E7bQc1G4YMAYli0cd1hau29w1HlA
         yz+qZPGbZB/PMbkCeqvmtFB8LoIUZsagHQmJQaD+SEDsGzfPclGPODSe0wpOJz+Nwlvb
         b5Sg==
X-Gm-Message-State: AAQBX9fhltm2DBHfbGq8m9x9dAhygLlNBhtsmSvRD6xffTNrKpXcSfSe
	nTeH070oyQnCjLxjv6QzX4sgpQ==
X-Google-Smtp-Source: AKy350bNr4KJH+ZbusBX8ddHYWCR5TF9ug/D4hQCNf5bE3nZzYv03gsenyNx3XTYaQjbqtu0borjcw==
X-Received: by 2002:a5d:6b0a:0:b0:2cd:bc79:5444 with SMTP id v10-20020a5d6b0a000000b002cdbc795444mr3747030wrw.2.1680690413210;
        Wed, 05 Apr 2023 03:26:53 -0700 (PDT)
References: <cover.1678351495.git.viresh.kumar@linaro.org>
 <20230405080512.nvxiw4lv7hyuzqej@vireshk-i7> <87h6tulkae.fsf@linaro.org>
 <20230405060340-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.10.0; emacs 29.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, qemu-devel@nongnu.org,
 virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 stratos-dev@op-lists.linaro.org, Oleksandr Tyshchenko
 <olekstysh@gmail.com>, xen-devel@lists.xen.org, Andrew Cooper
 <andrew.cooper3@citrix.com>, Juergen Gross <jgross@suse.com>, Sebastien
 Boeuf <sebastien.boeuf@intel.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 05 Apr 2023 11:24:43 +0100
In-reply-to: <20230405060340-mutt-send-email-mst@kernel.org>
Message-ID: <87cz4ilj4j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH V3 0/2] qemu: vhost-user: Support Xen memory mapping quirks


"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Apr 05, 2023 at 11:00:34AM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> Viresh Kumar <viresh.kumar@linaro.org> writes:
>>=20
>> > On 09-03-23, 14:20, Viresh Kumar wrote:
>> >> Hello,
>> >>=20
>> >> This patchset tries to update the vhost-user protocol to make it supp=
ort special
>> >> memory mapping required in case of Xen hypervisor.
>> >>=20
>> >> The first patch is mostly cleanup and second one introduces a new xen=
 specific
>> >> feature.
>> >
>> > Can we apply this now ? I have developed code for rust-vmm crates
>> > based on this and we need to get this merged/finalized first before
>> > merging those changes.
>>=20
>>=20
>> I've queued into my virtio/vhost-user-device series so I'll get merged
>> with that series unless mst wants to take it now.
>
> Well the patches are tagged and I was going to take these after the relea=
se.
> Probably easier not to work on this in two trees.
> Still if there's something in your tree being blocked
> by these patches then
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Let me know.

The virtio/vhost-user-device tree work is orthogonal to this vhost-user
enhancement although all the work is related to our latest VirtIO
project inside Linaro, Orko:
https://linaro.atlassian.net/wiki/spaces/ORKO/overview

So if you are happy please take these patches now for when the tree
re-opens.

>
>
>> >
>> > Thanks.
>>=20
>>=20
>> --=20
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

