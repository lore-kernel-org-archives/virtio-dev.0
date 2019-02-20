Return-Path: virtio-dev-return-5476-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EF9C1985DA5
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Feb 2019 19:29:48 +0000 (UTC)
Date: Wed, 20 Feb 2019 14:29:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190220142458-mutt-send-email-mst@kernel.org>
References: <20190212112547.GC2715@work-vm>
 <20190212144741.60083682.cohuck@redhat.com>
 <20190212090121-mutt-send-email-mst@kernel.org>
 <CAEkmjvW+bDjKeaoQOVm4CDVBfo-0qQf7uhk=sFMgSzeZTMzLKg@mail.gmail.com>
 <20190212164626.GG2715@work-vm>
 <CAEkmjvUU1VAEV+4Uy+QqYxR_atVVhVRR0XULVDyg+YJXwDYwDQ@mail.gmail.com>
 <20190219075415.v4xlw5ywrtmndew5@sirius.home.kraxel.org>
 <CAEkmjvU+8NXxMa3BYZdzkdvUJOMH315Q=a=U0Y_=D4CSiQNQcQ@mail.gmail.com>
 <20190219223936-mutt-send-email-mst@kernel.org>
 <CAEkmjvVV0xeVaygfYJpFkhrKtSLL9demMOC_=ubVcgO=yjJF9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkmjvVV0xeVaygfYJpFkhrKtSLL9demMOC_=ubVcgO=yjJF9w@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Greg Hartman <ghartman@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 20, 2019 at 07:24:20AM -0800, Frank Yang wrote:
> IPC though, seems like it would add quite some overhead,
> unless there's some generally accepted portable way to run via shared memory
> that doesn't also involve busy waiting in a way that burns up the CPU?

Let's just say designing host/guest APIs around specific OS limitations
doesn't sound like a good direction either.

Try talking to Chrome guys, I hear they are using process per plugin for
security too? What do they do for portability?

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

