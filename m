Return-Path: <virtio-dev-return-12012-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7BEC76188
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 10:01:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 92A4A2B056
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 10:01:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7835A9865B7
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 10:01:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5FC5B983DE1; Wed,  5 Apr 2023 10:01:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4E0D79865A7
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 Apr 2023 10:01:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680688906;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xDFJjTGQNkjMjQaKDKrEsiOprP+3eY5rMht1R3BPmqI=;
        b=fqSH4qRrFOn+Ec3FmymDFQsnpUj2hnlk4C9rbxSCH5ydPQbwo+IC3HrI1IZYpDD4kt
         opC868zKhk+JQpnG1BswhblWDDkiWh88ERpiOcQovIPCp721cMtAXp+bSCE1XQq8IxWc
         hAXxJcMdtppw9CZDYHTZL5Vt4ORc3k7hq2HtJqXv5EChA4sdAlH55N/Ajs5LCRlwu+j3
         ++Yb78iEaZXV3jFBncVvmCjtGTt5FnS1FWknNA0615ooOFJX6s7nsCHjPdgSisImu3rF
         wA6YfrqY/gU9G2goZ7ITUPo/Gt2/fEUYDy3C6iTB7LEMICQaCqdGK6YRsMGdnSNbHknj
         WHBQ==
X-Gm-Message-State: AAQBX9d72P96rhi/nToEYRCtFsAQaeeXyQYJWw/Eiavq2i9oRwtsYxrS
	eQaRBvkjGTQtNKtRny7eYujlhQ==
X-Google-Smtp-Source: AKy350ZtC2zcGgpmA1tObIYkI/B3t4R7tGoffPFGOXgc8gOET2D0kOgJ1A31FE4xklaO7MxIT2j8nA==
X-Received: by 2002:adf:f1cc:0:b0:2cf:e67c:8245 with SMTP id z12-20020adff1cc000000b002cfe67c8245mr3708097wro.44.1680688905956;
        Wed, 05 Apr 2023 03:01:45 -0700 (PDT)
References: <cover.1678351495.git.viresh.kumar@linaro.org>
 <20230405080512.nvxiw4lv7hyuzqej@vireshk-i7>
User-agent: mu4e 1.10.0; emacs 29.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, Stefan Hajnoczi
 <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, stratos-dev@op-lists.linaro.org,
 Oleksandr Tyshchenko <olekstysh@gmail.com>, xen-devel@lists.xen.org,
 Andrew Cooper <andrew.cooper3@citrix.com>, Juergen Gross
 <jgross@suse.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, Liu Jiang
 <gerry@linux.alibaba.com>, Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Wed, 05 Apr 2023 11:00:34 +0100
In-reply-to: <20230405080512.nvxiw4lv7hyuzqej@vireshk-i7>
Message-ID: <87h6tulkae.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH V3 0/2] qemu: vhost-user: Support Xen memory mapping quirks


Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 09-03-23, 14:20, Viresh Kumar wrote:
>> Hello,
>>=20
>> This patchset tries to update the vhost-user protocol to make it support=
 special
>> memory mapping required in case of Xen hypervisor.
>>=20
>> The first patch is mostly cleanup and second one introduces a new xen sp=
ecific
>> feature.
>
> Can we apply this now ? I have developed code for rust-vmm crates
> based on this and we need to get this merged/finalized first before
> merging those changes.


I've queued into my virtio/vhost-user-device series so I'll get merged
with that series unless mst wants to take it now.

>
> Thanks.


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

