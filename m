Return-Path: <virtio-dev-return-11797-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D89C76195
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5D60A68497
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FBB098649F
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0CC5E9863CE; Tue, 28 Mar 2023 00:00:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A026E98657E;
	Tue, 28 Mar 2023 00:00:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKrjomv5lRNC9HdDYnHN+weqUOVTcaR98QJ3hJ5A5oM1mVgQ4NgwS4HFEy+kI7CTSk/5E9vYT4adT9dqEkmfzo+eLi3F7h9qovfU5yRGnoNNV1M7ZYVsCE8Vzmi7CcwKODEEpapZlSrwGX4xVQR27uDvqXQHk7f3ZOPyRiLwbbhYr2rXF5owC36vC41O4ColN39hPoy4+fuhNSUK2eYPZRzbv4+HsHr2pcuLQAUssOKV8AxjmB3E22XRmbVHRQiAEiEpM8dLNeYqpxzKMARA6NECn+lXPw8GqQVP7smb0lyru5Nlnw+2ptUDbkw+7ELbLC4W26Ih2Gg99R49DmGjsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8+PvkaB45GxhWiBAu+r/8tJpgGI8n7Bei+qUz6pgWg=;
 b=QwrsHTuO178BWSg5XLGOVFLDwCYgcXbzOnxELXeJHl1FL/rRSZpIaEwlqU1zwk8e6Ggnv3E0IzbP18Cf6Rwnnaez9MaD8zEhvAAaQTLuMjJSDxVwYNac4YF5M7AX+orEFKNue+NlGuOHnz0UEE0yH3/G3pvr6znJOgDBxkGj+ZKpcZeopf7Sd8zPi5lXJyt7d20/KMF+vYREt5dFnLI48eAOa1/yh58Q6FsjYllqYyQePsr0EfxWyXssQZwoQt8b6HF5gnvLqvDydYBLinOB+WC3+3QBN1OPxXL//oNn/1mTmzNsE4BSuWW0cP9H2e/bNg7zO5J86rmoEHfXpf1mNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <sgarzare@redhat.com>, <virtio-comment@lists.oasis-open.org>,
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Date: Tue, 28 Mar 2023 02:59:30 +0300
Message-ID: <20230327235936.414196-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20230327235936.414196-1-parav@nvidia.com>
References: <20230327235936.414196-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: aec2c6a8-81da-4209-4d49-08db2f1f60cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TN7PiJMtmdKgF9hIpPyW2j02MS5DGh5JuGbtYX+jNCyMhmoNdGEn6XNHYQLWnaaiQJpCiGClawcTUEw7UCU6PHYUqNpM2fdLMXzJ8UdZIXcugOrHLok32qt+YOUStHZXOHG4OvWobF5z/ge1kiatnmj4d/s5AoI07T+rbJedo9qr+9G9oQKJRpZSRXurE7+iZoOpLcsJAuq3/ZG57ABmQ1JDuZsiUIUMQrJLC0vIvon+tXJ4oGqOyoy6zh2oUSEWXvuNSHB4xeXy2FA0znYoogtiSMhL/yQm/hEh5ymp6GDuRUisWU1W+znwXUaI8RfQb2boSMbz7K00nk7f0JX1qcfnO7r3CZh+0QUYNM/LEmuR4Bpw+tvx85kSA4jlOFp8QgpyB0ct3Jar+wJfNa2yS9redB7bacAkQ8QU1VuOORPbIn3QRwfnIfw3zG90N+9Ba5yvj25nPTIFFkbTCggAZeM3Qe1JOXs4G7I1A52uucHx8LHdirDf3sjZZ+edHLN4trKIJYwucTqODTOX241j6KkjpRzBLTV7Gea+dPD50EBKu/FBbfbu3DneyY5B/5bv3aYiHX536LnMR646jGU71S1IW35tdzMmKRf4t6K6rZV5o8MbOsBMkH4XY1jzUFsL+vAxbAbJgQ3OBYZRkOakvs6yUfGjy0aOw31WUkwLJW5hfxjTZQNT9b7HtI+kn1T6LzEzJNZeYQj5tlxpyBZxmcu8P1xlCZVEjLw2pidGG8eIbUH7FO0RvKvR3h8UEd7MBd3C5upJxD76liobnKA3sw4W4/jyHXZQodmy9FaYOk7sRDLgJU7zb2eTVSPsxYjvUqWVRkPI5MMHZwX54FJQzXcJBbDtcA7BBsSFLwvieLk=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(34020700004)(316002)(110136005)(40460700003)(36860700001)(54906003)(478600001)(356005)(7636003)(82740400003)(36756003)(8936002)(82310400005)(5660300002)(86362001)(2906002)(4326008)(70206006)(8676002)(70586007)(41300700001)(40480700001)(426003)(1076003)(107886003)(6666004)(186003)(26005)(16526019)(336012)(2616005)(83380400001)(47076005)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 00:00:01.5716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec2c6a8-81da-4209-4d49-08db2f1f60cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095
Subject: [virtio-dev] [PATCH v8 2/8] transport-pci: Refer to the vq by its number

Currently specification uses virtqueue index and
number interchangeably to refer to the virtqueue.

Instead refer to it by its number.

This patch is on top of [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v7->v8:
- remove note about first virtqueue number
- skipped Max's comment to put word 'structure' in same line as its
  crosses 65 chars limit per line
- reworded queue_notification data set line, as '=' and vq number
  wording was odd
v2->v3:
- addressed comments from Michael
- changed vqn to virtqueue number in the Note
- refer to vqn field instead of virtqueue number
---
 transport-pci.tex | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/transport-pci.tex b/transport-pci.tex
index b07a822..a554081 100644
--- a/transport-pci.tex
+++ b/transport-pci.tex
@@ -390,13 +390,15 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
 
 \item[\field{queue_notify_data}]
         This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated.
-        The driver will use this value to put it in the 'virtqueue number' field
-        in the available buffer notification structure.
+        The driver will use this value to put it in the field
+        \field{vqn} in the available buffer notification
+        structure.
         See section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
         \begin{note}
         This field provides the device with flexibility to determine how virtqueues
         will be referred to in available buffer notifications.
-        In a trivial case the device can set \field{queue_notify_data}=vqn. Some devices
+        In a trivial case the device can set
+        \field{queue_notify_data} to the vq number. Some devices
         may benefit from providing another value, for example an internal virtqueue
         identifier, or an internal offset related to the virtqueue number.
         \end{note}
@@ -1005,7 +1007,7 @@ \subsubsection{Device Initialization}\label{sec:Virtio Transport Options / Virti
 The driver typically does this as follows, for each virtqueue a device has:
 
 \begin{enumerate}
-\item Write the virtqueue index (first queue is 0) to \field{queue_select}.
+\item Write the virtqueue number to \field{queue_select}.
 
 \item Read the virtqueue size from \field{queue_size}. This controls how big the virtqueue is
   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Virtqueues}). If this field is 0, the virtqueue does not exist.
@@ -1035,7 +1037,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 
 When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
 the driver sends an available buffer notification to the device by writing
-the 16-bit virtqueue index
+the 16-bit virtqueue number
 of this virtqueue to the Queue Notify address.
 
 When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
@@ -1053,7 +1055,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
 If VIRTIO_F_NOTIF_CONFIG_DATA has been negotiated:
 \begin{itemize}
 \item If VIRTIO_F_NOTIFICATION_DATA has not been negotiated, the driver MUST use the
-\field{queue_notify_data} value instead of the virtqueue index.
+\field{queue_notify_data} value instead of the virtqueue number.
 \item If VIRTIO_F_NOTIFICATION_DATA has been negotiated, the driver MUST set the
 \field{vqn} field to the \field{queue_notify_data} value.
 \end{itemize}
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

