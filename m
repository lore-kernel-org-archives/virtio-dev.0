Return-Path: virtio-dev-return-7626-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E4C0D985A1B
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Aug 2020 16:41:26 +0000 (UTC)
Date: Mon, 10 Aug 2020 17:41:13 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20200810164113.GH3052@work-vm>
MIME-Version: 1.0
Subject: [virtio-dev] virtio-input for copy/paste?
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-dev@lists.oasis-open.org, kraxel@redhat.com
Cc: berrange@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,
  Is there anywhere that virtio has where host/guest copy/paste would
fit?   I don't think it's something we have defined at the moment
and I was wondering if virtio-input would be the right place to add it.
If the client driver supported the feature then the host would
hand it to the client, if it didn't it could insert a string
of key events.

  It probably needs some design to ensure that whatever we have
would work with existing guests and existing transports like VNC.

Dave

-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

