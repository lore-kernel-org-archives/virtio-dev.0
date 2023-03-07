Return-Path: <virtio-dev-return-11486-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822DBC6FD1A
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 17:20:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2A74A41F1C
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 17:20:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D18D59866E7
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 17:20:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A5D429866F8; Tue,  7 Mar 2023 17:20:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 26589986702
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Mar 2023 17:20:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: _MbyqFx8OJS_gBpTZIaWrw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678209608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4c/jjonrqmNyOFE95HXC5s3gnf6PpwJOBe7JbDtandI=;
        b=BaY7ubjPKikWw2y4SYE9j2ltIsbnNYGVLGuRWT00gf+qhxfT6cesj2Fbo0vdA74Y6L
         3LmDjXRBtSM5mpFpg7GrFBvT4k0/o5czcOCES03i3qnr+1lOvb5D3tmoBdVo23oVrOca
         pr/63NNnw+6FgxBGV1PfaiTawVAEuyMPCnaMwqZxqW5cq/m4dKxXgm3ioI3MZU3ob3Ne
         vVR2V6F2lbrKzeOgnG3K+YVMELvK3fWSMfRRpobEIYLqTaKt+pWOgWD+m7jNAVOAuBIb
         +q22r5Zs7dQeUTGqvBggBUAEdCRT9jS4gTf4E2ShFExjas3/QfSWwPPcgP1rc8aqo0Wj
         ziig==
X-Gm-Message-State: AO0yUKWZaJQJ6PvaC2s9kdWW+CR2ekJAzhlo/iCzijsmiG1/twbhBT9d
	VXWbiDUEQNzdD5Da1ELMfQst2MXPl7yMfwc+3IkMgS9DgPDvq4shl9lJKH7wCZWJQ26+dNAQ6is
	jydr7bedUg16rhhSPTJuQUroxOhPg
X-Received: by 2002:adf:da42:0:b0:2c7:16c3:175e with SMTP id r2-20020adfda42000000b002c716c3175emr9825321wrl.64.1678209608105;
        Tue, 07 Mar 2023 09:20:08 -0800 (PST)
X-Google-Smtp-Source: AK7set+6dUQP/Apzdx32m6cubqju33TTloihFSwu4eoMYxcGt7txqVAXW2E/CsMAEw0J5uqVJKYueA==
X-Received: by 2002:adf:da42:0:b0:2c7:16c3:175e with SMTP id r2-20020adfda42000000b002c716c3175emr9825306wrl.64.1678209607807;
        Tue, 07 Mar 2023 09:20:07 -0800 (PST)
Date: Tue, 7 Mar 2023 12:20:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230307121529-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <ZAXcqqdwfoLokT2l@nanopsycho>
 <20230306175020-mutt-send-email-mst@kernel.org>
 <ZAbmEmwsMMxKJqeB@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <ZAbmEmwsMMxKJqeB@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10 00/10] Introduce device group and
 device management

On Tue, Mar 07, 2023 at 08:21:54AM +0100, Jiri Pirko wrote:
> Mon, Mar 06, 2023 at 11:54:45PM CET, mst@redhat.com wrote:
> >On Mon, Mar 06, 2023 at 01:29:30PM +0100, Jiri Pirko wrote:
> >> Thu, Mar 02, 2023 at 02:04:48PM CET, mst@redhat.com wrote:
> >> 
> >> [...]
> >> 
> >> >
> >> >TODO (maybe?) - probably ok to defer until this part is upstream:
> >> >
> >> >	Add "all members" member id.
> >> >
> >> >	Add commands for MSI, feature discovery.
> >> >
> >> >	Add commands for transport vq.
> >> >
> >> >
> >> >My intent is to try and support both SR-IOV and SIOV
> >> >usecases with the same structure and maybe even the same
> >> >VQ.
> >> 
> >> Sorry to be late to the party, I'm trying to catch up. Is it common to
> >> have cover letter for features this brief? I mean, from the cover
> >> letter, I'm totally unable to understand what you are introducing here.
> >> 
> >> Could you elaborate about what you are aiming to achive with this?
> >> Could you shed some usecases perhaps?
> >> 
> >> I have to be missing something obvious, but I don't get why any notion
> >> of SR-IOV could be beneficial for virtio.
> >> 
> >
> >Good point, I'll add a bit of motivation.
> >
> >For SR-IOV, it is not unusual for PFs to excercise control over VFs.
> 
> I understand the concepts of SR-IOV. Yet I fail to see the need of such
> concept in virtio world. SR-IOV is very specific solution for PCI
> functions instantiation, and I believe that it is already considered
> quite limiting in many aspects. Does not make sense to me to introduce
> it for virtio. But again, I may be missing something crucial, I just
> would like to see the motivation, needs, usecases for this crystal
> clear, which is opposite to the current cover letter I'm afraid :/

First people are asking for it because it's out there, however limiting
it is. In fact Nvidia is - why don't you talk to Parav here and tell
him that SR-IOV is legacy and there's no need to support.




> 
> >There is interest in the community to include an interface to allow this
> >in the virtio spec, when the PF is a virtio device.  This is what this
> >patch does.
> 
> Yeah, but why? As I asked before, what are the usecases? The fact there
> is interest in the community does not mean it makes sense to have it :)
> 

If people want to build such hardware it will need some interface.
Far better to have it standard.


But generally e.g. intel already said they will reuse this
same structure with a different group type for SIOV support.
I'll mention this in the cover letter.

> >
> >
> >
> >
> >> >
> >> >For example, it might make sense to split creating/destroying
> >> >SIOV devices from the transport passing data from the guest - the
> >> >driver would then not negotiate VIRTIO_F_SR_IOV (which
> >> >then means auto-provisioning).
> >> >
> >> >This is out of RFC, since we have two commands which are useful
> >> >to discover supported group types (ATM can be none or SR-IOV).
> >> >
> >> >
> >> >Michael S. Tsirkin (10):
> >> >  virtio: document forward compatibility guarantees
> >> >  admin: introduce device group and related concepts
> >> >  admin: introduce group administration commands
> >> >  admin: introduce virtio admin virtqueues
> >> >  pci: add admin vq registers to virtio over pci
> >> >  mmio: document ADMIN_VQ as reserved
> >> >  ccw: document ADMIN_VQ as reserved
> >> >  admin: command list discovery
> >> >  admin: conformance clauses
> >> >  ccw: document more reserved features
> >> >
> >> > admin.tex        | 540 +++++++++++++++++++++++++++++++++++++++++++++++
> >> > content.tex      | 112 +++++++++-
> >> > introduction.tex |   3 +
> >> > 3 files changed, 653 insertions(+), 2 deletions(-)
> >> > create mode 100644 admin.tex
> >> >
> >> >-- 
> >> >MST
> >> >
> >> >
> >> >This publicly archived list offers a means to provide input to the
> >> >OASIS Virtual I/O Device (VIRTIO) TC.
> >> >
> >> >In order to verify user consent to the Feedback License terms and
> >> >to minimize spam in the list archive, subscription is required
> >> >before posting.
> >> >
> >> >Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> >> >Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> >> >List help: virtio-comment-help@lists.oasis-open.org
> >> >List archive: https://lists.oasis-open.org/archives/virtio-comment/
> >> >Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> >> >List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> >> >Committee: https://www.oasis-open.org/committees/virtio/
> >> >Join OASIS: https://www.oasis-open.org/join/
> >> >
> >> 
> >> This publicly archived list offers a means to provide input to the
> >> OASIS Virtual I/O Device (VIRTIO) TC.
> >> 
> >> In order to verify user consent to the Feedback License terms and
> >> to minimize spam in the list archive, subscription is required
> >> before posting.
> >> 
> >> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> >> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> >> List help: virtio-comment-help@lists.oasis-open.org
> >> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> >> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> >> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> >> Committee: https://www.oasis-open.org/committees/virtio/
> >> Join OASIS: https://www.oasis-open.org/join/
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

