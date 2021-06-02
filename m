Return-Path: virtio-dev-return-8178-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0D4CA986559
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Jun 2021 20:09:52 +0000 (UTC)
MIME-Version: 1.0
References: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
 <YJ07vrCt3thO5MM/@stefanha-x1.localdomain> <CABATKF_vRfnkybEyj-PejKYPud0=FNPscRJ9=ztKzWiySnyHVQ@mail.gmail.com>
 <adc1355d-7ecb-7617-536e-1082ecbba039@metux.net> <CABATKF-cFHeiLz1ruwKaYHHHo3xuoKcCods+WAzhXojo6wEO1w@mail.gmail.com>
 <40119ebe-04c5-ce46-e015-6e69086f2186@metux.net>
In-Reply-To: <40119ebe-04c5-ce46-e015-6e69086f2186@metux.net>
From: Hao Chen <chenhaosjtuacm@google.com>
Date: Wed, 2 Jun 2021 13:09:39 -0700
Message-ID: <CABATKF-t-xfj0cTa6zsnKJwLbXUCLaSZOqUWXDEOfKpR3KCPgw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] Add virtio parameter server device specification
Content-Type: text/plain; charset="UTF-8"
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

> If your goal is just to have a standard protocol then I think you can make
> it much easier for others to implement by publishing your own protocol
> spec that runs over a vsock socket.

> If its just reading / setting some kind of "variables" via some path
> name, why not using 9P for that ?

We can use any protocol to implement this, and publish it somewhere, but it
does not carry the same weight as putting it in the virtio spec. It is
easier to say
"we use virtio, and for this device we use virtio-xxx device", but it
would be weird to
say "we use virtio, but for this device, we use vsock+some other non-standard
protocol, please support this or you will break the compatibility".
That is why we
want to put parameter server as a new virtio device.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

