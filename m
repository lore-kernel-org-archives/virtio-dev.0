Return-Path: <virtio-dev-return-11808-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED93CC76195
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 11:28:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 44BFE3DF29
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 11:28:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 389609863E5
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 11:28:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2C88898634B; Tue, 28 Mar 2023 11:28:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1D5A298637D
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Mar 2023 11:28:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680002931;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vb0DTSv9wEHNLZijpIORbSppIJNmyE3YOU6O+WGux0E=;
        b=m6P/VY9HHqlE84rTLXJYsK7grovLDcHGVgI7okkPjUp3F01xKOClFK+hEV8AsSiZ1h
         O5Idi1F05OJ9E4YEmqItjwyl/3MHqz0A+Mme8EZjfEzlPVYBu/9sLASXx+AV+U3la84W
         3mbu5pxtfkP6Q8yhNdhavWXz+EAP9VC+nwPtqZVVtj73lYwtwcgDx8I96DiLJnrep1x5
         oKdLQO39K1ESdjz4UrQMxJkmXL9L5aRPKayVsjuYBT2JskId33TVSh339SugzCvqv5Rk
         OJATntZE2t2ucXmrVZlgpby4ZW6uJVbkax7ke/T4d67PszVeXvNNtMbIlYYJVnI99sZ8
         CmIg==
X-Gm-Message-State: AO0yUKVWJLrQrhGa5Gm8b3Imm+PJMqTFtEsqDL8oZOHVOkYXfMSSvZFv
	nqiHcuX5xEL/IFv6cgZsDI+Q+Q==
X-Google-Smtp-Source: AK7set9dTJkMQYlZNEtMnnUsOG7J832VNvyYYZs/1b3NcBIGkUnLhqbfE5332XP0aXA1RG5zIZ9LYw==
X-Received: by 2002:a7b:ce16:0:b0:3ed:9b20:c7c1 with SMTP id m22-20020a7bce16000000b003ed9b20c7c1mr10702075wmc.20.1680002931595;
        Tue, 28 Mar 2023 04:28:51 -0700 (PDT)
References: <cover.1678351495.git.viresh.kumar@linaro.org>
 <6d0bd7f0e1aeec3ddb603ae4ff334c75c7d0d7b3.1678351495.git.viresh.kumar@linaro.org>
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
Date: Tue, 28 Mar 2023 12:28:45 +0100
In-reply-to: <6d0bd7f0e1aeec3ddb603ae4ff334c75c7d0d7b3.1678351495.git.viresh.kumar@linaro.org>
Message-ID: <87wn31qfm5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH V3 2/2] docs: vhost-user: Add Xen specific memory
 mapping support


Viresh Kumar <viresh.kumar@linaro.org> writes:

> The current model of memory mapping at the back-end works fine where a
> standard call to mmap() (for the respective file descriptor) is enough
> before the front-end can start accessing the guest memory.
>
> There are other complex cases though where the back-end needs more
> information and simple mmap() isn't enough. For example Xen, a type-1
> hypervisor, currently supports memory mapping via two different methods,
> foreign-mapping (via /dev/privcmd) and grant-dev (via /dev/gntdev). In
> both these cases, the back-end needs to call mmap() and ioctl(), with
> extra information like the Xen domain-id of the guest whose memory we
> are trying to map.
>
> Add a new protocol feature, 'VHOST_USER_PROTOCOL_F_XEN_MMAP', which lets
> the back-end know about the additional memory mapping requirements.
> When this feature is negotiated, the front-end will send the additional
> information within the memory regions themselves.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

