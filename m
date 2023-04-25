Return-Path: <virtio-dev-return-12402-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2584BC6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 12:45:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3AA253E30C
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 12:45:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 162F6986463
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 12:45:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EC5A798643D; Tue, 25 Apr 2023 12:45:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA6FB98643E
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Apr 2023 12:45:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: OGDiElA8MuW_E7FBWehShg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682426728; x=1685018728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krc+SiJhBUwO2ug/XwTx3KTJqkkR2CFS+eg5Dz5ylJc=;
        b=K1IwKgKVH40EGNKfOhne0j3alm33W8tgHdBOPFjoXpsqLn9RgyX/yMItc1BdILXCi3
         Rdin6BNPZ3/Mmi09un/+DMEzz1ZItXuRCEomnYOAmLkvarUbpSDnbU8OIt1XLitJ5TRn
         SWsxxEf0ziGvBuZFpCQ2K+ox+qIvqgDiholTJuGXdRPZ4bn5N/tgWUrdh9ZuW7Dc/AiW
         lmS1DWd/eN5xDOdLppBeRY4QkO1JdXWcrcV/q6M9Lp9UwjYwVysLVNQbB+5a6BZIW5oT
         YZ9Q0UXZnmMW7icT5ggZjkFpfnfq1L13IvwxjeKAJW8YSQ1RiItG9dOjaAYP414Q4vQ1
         NGxg==
X-Gm-Message-State: AAQBX9fMQsolLBCpYYzUaeFhSSDQpitxEL67tYsAv/MoYYOAb8dA4dDM
	gJy7wNtKaUs84/w0XK4oLGXCK5neNX7N9uQhj2dzJHtG5BrF1PUGfxYbiuequyhKNmu/uV9wSRd
	IAI9SamaRnnPjp065FhBbP32umVXA
X-Received: by 2002:a05:600c:2214:b0:3f1:987b:7a28 with SMTP id z20-20020a05600c221400b003f1987b7a28mr7195380wml.29.1682426728235;
        Tue, 25 Apr 2023 05:45:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350bIPgn166ZA/wJ8PFmg9nFmKKBjNCYwRGQ/sI+aE3t+loxoVTTzjiSf9BdLyfiT4aA9pr1zIA==
X-Received: by 2002:a05:600c:2214:b0:3f1:987b:7a28 with SMTP id z20-20020a05600c221400b003f1987b7a28mr7195359wml.29.1682426727867;
        Tue, 25 Apr 2023 05:45:27 -0700 (PDT)
Date: Tue, 25 Apr 2023 08:45:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
	virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Harald Mommer <harald.mommer@opensynergy.com>
Message-ID: <20230425084503-mutt-send-email-mst@kernel.org>
References: <20230424-modular-rebate-e54ac16374c8-mkl@pengutronix.de>
 <20230424170901-mutt-send-email-mst@kernel.org>
 <20230425-oxidizing-blandness-ca9cc2cf114e-mkl@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20230425-oxidizing-blandness-ca9cc2cf114e-mkl@pengutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH] can: virtio-can: cleanups

On Tue, Apr 25, 2023 at 11:17:20AM +0200, Marc Kleine-Budde wrote:
> On 24.04.2023 17:09:23, Michael S. Tsirkin wrote:
> > On Mon, Apr 24, 2023 at 09:47:58PM +0200, Marc Kleine-Budde wrote:
> > > Address the topics raised in
> > > 
> > > https://lore.kernel.org/20230424-footwear-daily-9339bd0ec428-mkl@pengutronix.de
> > > 
> > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > 
> > given base patch is rfc this should be too?
> 
> This is an incremental patch that fixes the topics I raised in the
> review of "[RFC PATCH v2] can: virtio: Initial virtio CAN driver.", see
> linked discussion thread.
> 
> regards,
> Marc

and that's fine, just pls put RFC in the subject.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

