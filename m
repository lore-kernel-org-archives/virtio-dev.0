Return-Path: <virtio-dev-return-11802-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379B6C76195
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:01:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A0F7F3F57B
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9596C986569
	for <virtio-dev@archiver.kernel.org>; Tue, 28 Mar 2023 00:00:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8AB6598633D; Tue, 28 Mar 2023 00:00:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E827D986547;
	Tue, 28 Mar 2023 00:00:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npv9ZM+AFSUqBBNTBI+eERi0l8sCNdjxedCAswumND2bhRXoOgcxjLwi9viNLdVpwj7BuYbBtpquvGvB4eKK2R+wi+lNLl+3l7/CVFDa+Cafq7oc3Z6mJYK3nmWMQEWm1fJVa0z2PO3jtkkfrxo7tMd13hvTnheWd2kHd/QfOZevshyhOsxdx33QkFIw4HRDG4PX4AHt/W1RBpAteD23n6lFoaLdluNH8Hu6Pz+SnR0JY8324or6atrjqvj+lLV9AjgZ05vCsbKfKNiVE8wOnOdAM3P3sBndxIwlf8dbFcqul5GuRgbPVxDMteCk19N20z85/mu+wdGwqT6Bi3VtOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcyMZN0RuyQjhc65CB01H31HgGj7Oro9NQwIVEqgGQk=;
 b=SbaSkz0zqyXtW9owd7XMKOoJJFB/qWLrIxawteAh//jDqu1IRX+76F6f3Hx+2Af+SLgc4byAFUDLdGx3fblAkUri4N5KGdOtnaTW4nQJCv/lFNg5dEM7MoAUKu2UEyUtN4vK9UYzn76bzEcBYRtx8D9jaXDi9UgMWTHaZaCAQZS5dra8VeKIahpuV5hFPLWF1hj8DnOK+a02p+QWdqu7MQWmI2AiP0ZYdsfb0IlTEfAHqz86rClmWvpUUPqNF93JX3TujEZ/ACpe20rr/Lkkhj5+EUDqy8LHyzpfpuZxgdudXlBGFGpKSc812XKMIEUD9bDRjyi9ma/5WFmwlGnuVQ==
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
	<shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>
Date: Tue, 28 Mar 2023 02:59:35 +0300
Message-ID: <20230327235936.414196-8-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|PH7PR12MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf95de2-0616-4795-963a-08db2f1f659b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cRh7tTyiIgaTY2ieNfCo5mWGxFlk5f7PHPiMUcndPyINKrDXVbtbJY35dUuhegBMy1kqmR+63DbwfIt1FaRbFDz6Gxl8cMdL8XmZ6YZC3z9PltsLwT0HdVOG8Sa6kZEudqq0AzD22mAax+hIG1OQJqp8AiUikGk8wtYvopYQcwC8Ix5VdIgDdJPE1PeiTGPohjPKLwbkG5AZBovlPM1HPQmzh4YviUyoloc7372DimOtFEDhXjv9GQs8TVCoE/dNj50dkC7LGw6zKr2G5VRdj0BdGj8LBZDCGUxq1/U/U3CQZpZW89m1vfdTZnvu7GR01waiuc6Pg0M9bVCU8IoDNW5+MZR6svbQ6IQoNa5UiIV5JpVz2DlBtUOecCphNrarLj7mleYRZCf/W758w0ZPgWxk4vK77qjcOz0X9N3EEb9wt4RvPrF8tT9VIurgkP2A0vMjFFRHK+xBX1wTuz4N2nfb51toCO8ifd2yzbUPtxMzW6W17wc577apMatNX6vooHanZqe58N7IacWypnhGeFDaSseGxtegqmN9/13ezGXVfCH5Dwa3snGdc8n4yEcqNeBz+peeiQzYuGmuCE9gUlbJaMfjTH/C5sXaa+IpfUEBc0hrwx2AtfXn97+jaJp5eyEmIUMZNUEnCi8XWveYNE5SNUa0uGv5/A7SzhpdvAyYlXeREeMjvlVA1zef6mODFLCBfdhaFnE6BAT8ST+WsGtoPFqut6qA+IBwdKLwQcKE2cFg3+5sggb6SSFvevE0Veeaf/DHTeLFu5ZWTMpZS6KYU7RBMiuDWt95p1F+sL7iDbP9Q5pLdNAWC9c+2ZJK
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(34020700004)(316002)(110136005)(40460700003)(36860700001)(54906003)(478600001)(356005)(7636003)(82740400003)(36756003)(8936002)(82310400005)(5660300002)(86362001)(2906002)(4326008)(70206006)(8676002)(70586007)(41300700001)(40480700001)(426003)(1076003)(107886003)(6666004)(186003)(26005)(16526019)(336012)(2616005)(83380400001)(47076005)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 00:00:09.6369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf95de2-0616-4795-963a-08db2f1f659b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5653
Subject: [virtio-dev] [PATCH v8 7/8] virtio-net: Avoid duplicate receive queue example

Receive queue number/index example is duplicate which is already defined
in the Setting RSS parameters section.

Hence, avoid such duplicate example and prepare it for the subsequent
patch to describe using receive queue handle.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/net/description.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index d7c8b1b..435c1fc 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -1467,8 +1467,8 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 The device MUST determine the destination queue for a network packet as follows:
 \begin{itemize}
 \item Calculate the hash of the packet as defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets}.
-\item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure (value of 0 corresponds to receiveq1).
-\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq (value of 0 corresponds to receiveq1).
+\item If the device did not calculate the hash for the specific packet, the device directs the packet to the receiveq specified by \field{unclassified_queue} of virtio_net_rss_config structure.
+\item Apply \field{indirection_table_mask} to the calculated hash and use the result as the index in the indirection table to get 0-based number of destination receiveq.
 \item If the destination receive queue is being reset (See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}), the device MUST drop the packet.
 \end{itemize}
 
-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

