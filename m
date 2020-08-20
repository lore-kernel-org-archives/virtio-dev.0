Return-Path: virtio-dev-return-7690-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B4E56985E3C
	for <virtio-dev@lists.oasis-open.org>; Thu, 20 Aug 2020 08:22:54 +0000 (UTC)
Date: Thu, 20 Aug 2020 10:22:47 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200820082247.jxx4h5cgo34l637n@sirius.home.kraxel.org>
References: <20200810164113.GH3052@work-vm>
 <20200817051547.3cnv5jdrwcfr3xwe@sirius.home.kraxel.org>
 <20200819153528.GA2980@work-vm>
 <20200820053250.jy3fwuhy5josnfog@sirius.home.kraxel.org>
 <20200820075003.GA2664@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200820075003.GA2664@work-vm>
Subject: Re: [virtio-dev] Re: virtio-input for copy/paste?
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, berrange@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > Guest UI too (you can make the same argument the other way around) if we
> > want support guest->host cut+paste.
> 
> OK, I was less worried about the host stealing from the guest, since it
> normally already can.

Yes, typically that would less concerning.  I wouldn't completely ignore
it though, SEV exists for a reason.  Also you might not want cut+paste
inside the guest overwrite the host clipboard.

take care,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

