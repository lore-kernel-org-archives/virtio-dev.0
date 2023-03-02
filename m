Return-Path: <virtio-dev-return-11359-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90364C7EE30
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 11:12:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CBD7629FE8
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 11:12:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C5E3698669B
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 11:12:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BB8F0986676; Thu,  2 Mar 2023 11:12:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A43F5986674
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 11:12:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: oo46BsBBMeKaM5K7HU5t7Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677755557;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jW4/JXdMP8+qlT6OWqWsTYwdNURvSN/T0aipPpLvnk=;
        b=mhWhILw687ID/Meyh1rJdMyG+KoqAtJ8Tf2eAX11JRZG/e/yLranXnQNcg3F89HC0X
         LvxomiTL0ykNnubjFI15A8NWX/2Nqwb2unRS6hZxsSRyaW014uAFfbo7IFy83DnKCURX
         ELlV45+aaEhpCsEvlC3gohPqWdKALOLjY7TVuEl3kIuRuRdD7RD1XnlIqsAX0xDjNu7T
         sMIewItpy0BWHVactMtf+MBICLUcLfmcHfJe0b6AO6q+RI6Rg8SdzGESOP4RiyuNOenb
         2xgFy+xZFIN2uBXLp+1OyjFia5exZC1DOaYnite+AtXg2F+cvcTsRS63SOeFeMrhQYEB
         5y7Q==
X-Gm-Message-State: AO0yUKXMLpu7YTBOIynbewNwl1ppEyVm5FC7R1+rJ6qJvMIg+Zlc0saH
	YjtEnOTNZaDYBHPMYw9XM2jo1nx1CuY89QMA/vLtE0hXzFdi6ZKFf91UcFSY9TpCtNVJSpQVVpz
	22NYsK0iDxaUnUBUDzzCFjdFEExuN
X-Received: by 2002:a5d:43ca:0:b0:2c7:16c3:1756 with SMTP id v10-20020a5d43ca000000b002c716c31756mr7658385wrr.61.1677755557015;
        Thu, 02 Mar 2023 03:12:37 -0800 (PST)
X-Google-Smtp-Source: AK7set83zR539oJeRJ5f5d7N8v6VQeDxQdnRsGFe4o+pIcmxP91xj+dKLZ2T7mYSerS8ApHEvDkNZQ==
X-Received: by 2002:a5d:43ca:0:b0:2c7:16c3:1756 with SMTP id v10-20020a5d43ca000000b002c716c31756mr7658371wrr.61.1677755556719;
        Thu, 02 Mar 2023 03:12:36 -0800 (PST)
Date: Thu, 2 Mar 2023 06:12:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
Message-ID: <20230302111232.837604-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH] makediff: make it work for fresh checkout

1st time one checks out our repo, latexdiff submodule
is not initialized. Pass --init to update command
to initialize it. It seems to be harmless if already
initialized.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 makediff.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/makediff.sh b/makediff.sh
index c925c5f..f65a2b4 100755
--- a/makediff.sh
+++ b/makediff.sh
@@ -44,7 +44,7 @@ latexpand $MAIN -o flat.tex
 cd "${cur}"
 #wget http://mirror.math.ku.edu/tex-archive/support/latexdiff/latexdiff-fast
 #chmod +x latexdiff-fast
-git submodule update latexdiff
+git submodule update --init latexdiff
 make -C latexdiff mkdirs dist/latexdiff-fast
 ln -fs ./latexdiff/dist/latexdiff-fast ./latexdiff-fast
 ./latexdiff-fast \
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

