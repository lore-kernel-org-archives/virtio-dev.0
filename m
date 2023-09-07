Return-Path: <virtio-dev-return-13652-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3528EC8759
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Sep 2023 19:55:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5031161275
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Sep 2023 19:55:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F30B698660E
	for <virtio-dev@archiver.kernel.org>; Thu,  7 Sep 2023 19:55:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D95AB986602; Thu,  7 Sep 2023 19:55:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B99BB9866B2
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Sep 2023 19:55:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Y7PXcdM_OlaP3Zeoi4f6nw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694116549; x=1694721349;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZ9ZRaGY7HhpgVeNCCze9OatONauXr+5NAfTMIMyxfY=;
        b=kzvMe6j3JJ9sy9V7xKpH1WAPbBfxn1nOHq4ADxtoscjUXNSY5/S8b5HR4hwg71QYAi
         nRi2EAS1uGjGn/ZdiPFWUrYId6W2D0GfYRopGEpoprIMdTOJRY6QpG0tebWyTzOgWyyZ
         Y10Ea5OkGf2X9eVeVChxOO/e8bZRm8uraemfyiF0Ov7Uu0hwLqsQSUqK6WWqNtY8/6XW
         FqL+8ArugSbm5IN8pQW1qTV7ncH74q6I/KvFbXJ+JegHJN+kOArEDXFVPmmhcVtgDa9P
         7xPPP3qE87I/4sX9l6OfN2JS9+gxatghMCMSSrfjOxQKWAKM96Yv46OKIQOIjtDxM4IH
         14fg==
X-Gm-Message-State: AOJu0YzCapM+n6KCJvSL5hzejp1J6F8J+xGQqChN9IVprZhYwMolD95S
	E1rS3QGeL9buMq0Iuc3nUadwxJJzh+SMBiYW3JVWF1+nJvwNo4S1DeOLFTMKmN22jhRXy+uP4mK
	FaZU64TNtJtaoQWIjcvdv62F9Ax2vdbOdTDBT
X-Received: by 2002:a17:906:3042:b0:9a1:d2ef:3e3c with SMTP id d2-20020a170906304200b009a1d2ef3e3cmr226656ejd.44.1694116549013;
        Thu, 07 Sep 2023 12:55:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRLN7FZqhdys/YrgfIoahZwgyaXbFDSpBzBjdV5ydVjvTBGYb49w4TdI4srloesuwE0GCxzA==
X-Received: by 2002:a17:906:3042:b0:9a1:d2ef:3e3c with SMTP id d2-20020a170906304200b009a1d2ef3e3cmr226648ejd.44.1694116548652;
        Thu, 07 Sep 2023 12:55:48 -0700 (PDT)
Date: Thu, 7 Sep 2023 15:55:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>, jasowang@redhat.com,
	cohuck@redhat.com, stefanha@redhat.com,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230907155414-mutt-send-email-mst@kernel.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906042851-mutt-send-email-mst@kernel.org>
 <aa6101cc-caf6-95e9-89cd-614ac7a43e55@intel.com>
 <20230906094742-mutt-send-email-mst@kernel.org>
 <CAJaqyWfccvVwcbg4Sg7RbRd851+C+FzF0tvDmO6Vrt2TmwsehQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWfccvVwcbg4Sg7RbRd851+C+FzF0tvDmO6Vrt2TmwsehQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state

On Thu, Sep 07, 2023 at 12:57:58PM +0200, Eugenio Perez Martin wrote:
> On Wed, Sep 6, 2023 at 3:49 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Sep 06, 2023 at 04:38:44PM +0800, Zhu, Lingshan wrote:
> > >
> > >
> > > On 9/6/2023 4:29 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Sep 06, 2023 at 04:16:32PM +0800, Zhu Lingshan wrote:
> > > > > This series introduces
> > > > > 1)a new SUSPEND bit in the device status
> > > > > Which is used to suspend the device, so that the device states
> > > > > and virtqueue states are stabilized.
> > > > >
> > > > > 2)virtqueue state and its accessor, to get and set last_avail_idx
> > > > > and last_used_idx of virtqueues.
> > > > >
> > > > > The main usecase of these new facilities is Live Migration.
> > > > >
> > > > > Future work: dirty page tracking and in-flight descriptors.
> > > > oh that answers my question - it's not covered.
> > > > I don't think we can merge this without in-flight descriptor
> > > > support.
> > > When SUSPEND, we require the device wait until all descriptors that
> > > being processed to finish and mark them as used.(In patch 2)
> > > at this point there may be no in-flight descriptors, so this is still
> > > self-consistent. The tracker for in-flight descriptors is excluded to
> > > make this series small and focus.
> >
> > Does not work generally.
> > Imagine RX ring of a network device for example. You can wait
> > as long as you can but if there's no incoming network traffic
> > buffers will not be used.
> >
> 
> The patch should word it differently, yes.
> 
> QEMU's vhost-kernel net handler currently assumes the device will use
> the descriptors sequentially from avail_idx. In that case, it is
> possible to simply finish receiving in-flight packets (not buffers)
> and just stop receiving new packets. As all packets has been received,
> we have a valid used-idx, and the device at resume (or the destination
> device at migration) can just fetch all buffers from there.
> 
> I may have a better wording of this in other mails.
> 
> Would it work to use this solution with in_order, and defer the
> inflight buffers handling for the future? It would allow to keep this
> series small.
> 
> Thanks!

in_order isn't used widely so I doubt depending on it is wise.
And again the whole things has to be rewritten with admin queue
and the group owner generally does not know whether in_order
was negotiated by member or not.


> > Also please, keep to the spec terminology. buffers are used not
> > descriptors. Best to keep it straight errors will not leak into
> > spec.
> >
> >
> > > >
> > > >
> > > >
> > > > > This series addresses many comments from Jason, Stefan and Eugenio
> > > > > from RFC series.
> > > > >
> > > > > Zhu Lingshan (5):
> > > > >    virtio: introduce vq state as basic facility
> > > > >    virtio: introduce SUSPEND bit in device status
> > > > >    virtqueue: constraints for virtqueue state
> > > > >    virtqueue: ignore resetting vqs when SUSPEND
> > > > >    virtio-pci: implement VIRTIO_F_QUEUE_STATE
> > > > >
> > > > >   content.tex       | 118 ++++++++++++++++++++++++++++++++++++++++++++++
> > > > >   transport-pci.tex |  18 +++++++
> > > > >   2 files changed, 136 insertions(+)
> > > > >
> > > > > --
> > > > > 2.35.3
> > > > >
> > > > >
> > > > > This publicly archived list offers a means to provide input to the
> > > > > OASIS Virtual I/O Device (VIRTIO) TC.
> > > > >
> > > > > In order to verify user consent to the Feedback License terms and
> > > > > to minimize spam in the list archive, subscription is required
> > > > > before posting.
> > > > >
> > > > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > > > List help: virtio-comment-help@lists.oasis-open.org
> > > > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > > > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > > > > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > > > > Committee: https://www.oasis-open.org/committees/virtio/
> > > > > Join OASIS: https://www.oasis-open.org/join/
> > > > >
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

