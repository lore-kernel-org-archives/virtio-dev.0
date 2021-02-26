Return-Path: virtio-dev-return-8047-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3360C986226
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 Feb 2021 11:16:35 +0000 (UTC)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 26 Feb 2021 11:16:19 +0000
Message-Id: <20210226111619.21178-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Subject: [virtio-dev] [VHOST USER SPEC PATCH] vhost-user.rst: add clarifying language about protocol negotiation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: qemu-devel@nongnu.org, rust-vmm@lists.opendev.org
Cc: stratos-dev@op-lists.linaro.org, virtio-dev@lists.oasis-open.org, viresh.kumar@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Jiang Liu <gerry@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

In practice the protocol negotiation between vhost master and slave
occurs before the final feature negotiation between backend and
frontend. This has lead to an inconsistency between the rust-vmm vhost
implementation and the libvhost-user library in their approaches to
checking if all the requirements for REPLY_ACK processing were met.
As this is purely a function of the protocol negotiation and not of
interest to the frontend lets make the language clearer about the
requirements for a successfully negotiated protocol feature.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Cc: Jiang Liu <gerry@linux.alibaba.com>
---
 docs/interop/vhost-user.rst | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index d6085f7045..3ac221a8c7 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -301,12 +301,22 @@ If *slave* detects some error such as incompatible fe=
atures, it may also
 close the connection. This should only happen in exceptional circumstances=
.
=20
 Any protocol extensions are gated by protocol feature bits, which
-allows full backwards compatibility on both master and slave.  As
-older slaves don't support negotiating protocol features, a feature
+allows full backwards compatibility on both master and slave. As older
+slaves don't support negotiating protocol features, a device feature
 bit was dedicated for this purpose::
=20
   #define VHOST_USER_F_PROTOCOL_FEATURES 30
=20
+However as the protocol negotiation something that only occurs between
+parts of the backend implementation it is permissible to for the master
+to mask the feature bit from the guest. As noted for the
+``VHOST_USER_GET_PROTOCOL_FEATURES`` and
+``VHOST_USER_SET_PROTOCOL_FEATURES`` messages this occurs before a
+final ``VHOST_USER_SET_FEATURES`` comes from the guest. So the
+enabling of protocol features need only require the advertising of the
+feature by the slave and the successful get/set protocol features
+sequence.
+ =20
 Starting and stopping rings
 ---------------------------
=20
--=20
2.20.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

