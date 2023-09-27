Return-Path: <virtio-dev-return-13978-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E815AE82CA5
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 15:55:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 363CA70FEE
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 15:55:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 079859866B1
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 15:55:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DC9FB9864C6; Wed, 27 Sep 2023 15:55:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC6199864C1
	for <virtio-dev@lists.oasis-open.org>; Wed, 27 Sep 2023 15:55:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Bra5UO7VNWuzNUL_bCdQQA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695830125; x=1696434925;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MXze5GTv1c99MGeDMPMpMArTuehJWNWg5PNwz6HOSaE=;
        b=I8QdAu53Y5SmmB8TGaS0XencRUL0V4Za0slRDavTfZ3KLoXY8XXveYQ4+Har7zlk/W
         Z6B4GiJX/6Qbp4jHbbu7X08F/k8O+9Ne/5SGMex4Z3hRvuXrsgV0gUEwtAI9mFxIB+n2
         FK6dWf0Q1LhVJIQalSBV/4yyC36+RuQ+QPl3tFR3nlpTqe3VyrurfsRxr4D4W41OACvN
         Ule+Dslwo/4naW8UMQFbyDOZFqMkpNgP5YtGuKluUV6mBpw4B8zdrn/eTm1vKjO/s48v
         dHiYoVA8m7EKlCDrti+QapJcMENT/8MJ/TWMmD6KupI4mweTxIrubpY9DjhRRxSQ5GE+
         ODoQ==
X-Gm-Message-State: AOJu0Yz/xVX6XwYmmkc9uRLl14TKeF7LuZA2XRT6UU5zYmBysZNz3BTP
	uBFJnVvpKSzDdw1qdxGvG70OqgOO9wkWSQOVv2k4UrRrpCqlc1CFNTAdrdd32p+5ZYXBl/DfCp6
	m3VkCNhWs/UOdRj2foNm7SjbdMzSkIcnloHoB
X-Received: by 2002:a5d:568e:0:b0:323:2038:944 with SMTP id f14-20020a5d568e000000b0032320380944mr2132828wrv.58.1695830124977;
        Wed, 27 Sep 2023 08:55:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFhJ2DEyBP/JopeGoVmGB9/7tOFfubT2PSzqeT/AXh9Ye5qs105I9+ZqB533PtZax6SxRzTg==
X-Received: by 2002:a5d:568e:0:b0:323:2038:944 with SMTP id f14-20020a5d568e000000b0032320380944mr2132815wrv.58.1695830124608;
        Wed, 27 Sep 2023 08:55:24 -0700 (PDT)
Date: Wed, 27 Sep 2023 11:55:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
Message-ID: <f58da8a0fd3a40b24c9643499a2592d3ad38b73c.1695830118.git.mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH] html: add missing enumitem package

makediffhtml.sh currently fails with:

! Missing number, treated as zero.
<to be read again>
                   \c@*
l.25850 \begin{enumerate}[label=\alph*
                                      .]
?
! Emergency stop.
<to be read again>
                   \c@*
l.25850 \begin{enumerate}[label=\alph*
                                      .]

Some web searches turned up suggestions to use enumitem and in fact,
virtio.tex already does this - but virtio-html.tex doesn't.

Adding \usepackage{enumitem} in virtio-html.tex too fixes the issue.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 virtio-html.tex | 1 +
 1 file changed, 1 insertion(+)

diff --git a/virtio-html.tex b/virtio-html.tex
index c822a99..48c633d 100644
--- a/virtio-html.tex
+++ b/virtio-html.tex
@@ -31,6 +31,7 @@
 \usepackage{tabularx}
 \usepackage{underscore}
 \usepackage{xstring}
+\usepackage{enumitem}
 \usepackage{chngcntr}
 \counterwithout{footnote}{chapter}
 
-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

