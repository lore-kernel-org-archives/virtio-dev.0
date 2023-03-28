Return-Path: <virtio-dev-return-11807-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE796C76195
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 11:27:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DB9B926A2F
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 11:27:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A51FF9863D4
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 11:27:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9250598634B; Tue, 28 Mar 2023 11:27:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7E3A498637D
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Mar 2023 11:27:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680002835;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mmLVWRHv9Mce/1Gxtf/hiKt4uOFJk025+sXNL5BqVhI=;
        b=B3Ay9Yu8Q5/NLQlDIh2kfgcEMZzEo4z2gQrm+geCjysbshTdexmdxgPh0p8OvMdd/y
         Cf32fuOPljtMDj1rSt0k4VS34HtwBgRdz77c4pjVqm0EbTHtb2m9FsXT7Dc3+4olbkx5
         BoWxxtpaFPmxtzBNuO5aa9anFFfyDUb2d17zw7SkUI8w8Owwu+YR2doEdbZvuxaxk0+Z
         2014MyxGDBIakbe1kEkLv06uKHfiwBzA8JTY2wD+1bbjRSdwhL8Y4jczohGpLq36dZTz
         wPIbSfrBgTTlqWr8EmDzU2hHt+HmeZrNC1ftWvyiXFEBGVZdvo3K1x+PhlY46Sb8FCMw
         vbRA==
X-Gm-Message-State: AO0yUKWxTn+wHSUr8xCiJIg9kDkfZNGD+jBZHtSlf9uVe647kx/l3Y2L
	NC2XJ7xEV4yw45hTaXRemdibUg==
X-Google-Smtp-Source: AK7set/rKuJeCLEfn8iMwesAs+RUH7DbxCveNvjd+59wlqYXnKCIHEaAUVqNtzWdJIjs2hdckl2YNw==
X-Received: by 2002:a7b:cd88:0:b0:3ee:7061:1bdd with SMTP id y8-20020a7bcd88000000b003ee70611bddmr11925479wmj.4.1680002834958;
        Tue, 28 Mar 2023 04:27:14 -0700 (PDT)
References: <cover.1678351495.git.viresh.kumar@linaro.org>
 <7c3718e5eb99178b22696682ae73aca6df1899c7.1678351495.git.viresh.kumar@linaro.org>
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
Date: Tue, 28 Mar 2023 12:27:09 +0100
In-reply-to: <7c3718e5eb99178b22696682ae73aca6df1899c7.1678351495.git.viresh.kumar@linaro.org>
Message-ID: <871ql9ru99.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH V3 1/2] docs: vhost-user: Define memory region separately


Viresh Kumar <viresh.kumar@linaro.org> writes:

> The same layout is defined twice, once in "single memory region
> description" and then in "memory regions description".
>
> Separate out details of memory region from these two and reuse the same
> definition later on.
>
> While at it, also rename "memory regions description" to "multiple
> memory regions description", to avoid potential confusion around similar
> names. And define single region before multiple ones.
>
> This is just a documentation optimization, the protocol remains the same.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

