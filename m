Return-Path: <virtio-dev-return-11287-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F86C7EE2D
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:31:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1225C87CB9
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:30:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02EBC98679E
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 22:30:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E9716986784; Sat, 25 Feb 2023 22:30:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C13B99866A9;
	Sat, 25 Feb 2023 22:30:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SplOw/zpD2sl2YnWlEpy0pqfcxA8++SDtF+SU1QesHAj4j88mnQ5xR/iwFtF/tmrYQ5VHuHZ2g8tOywO2Vx1+rpRYaL09b8bGfJmHsE9AucqSnkctWs2iVn4M138R5WKhH6lqed37kOcp06jJu3accJ+OgYhBdNdPIGAR0guLOJ2QYP/8vJ92FIK83W9m5CK41ZuM1IftnHmjMfONExiKzqUn0nlnymBl8aVoDeoPkE5CzqijSQX+U5pA2Z1iNH+DTu6Btl8zOwOI+Yqjt6l43KX2umHRziGbe4bHszUV3LiZ3AsWDwQKos1+QV6YmZOHItjDGPqKqwCd9xBMFIydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVvC/4FlY9lGbD0WyTOvaN/FtEVwfUUZZjqFe4kY/NI=;
 b=X0Sk8k4MkiNLClahU2Su9ciIymvvC0lV4z6kX3PzKGULKC6OCpBE56j3CUSNGHxq7+HZU87v69JiLofaT1zn32jMp2BdzJTHqwDQrFaEHTD9iEFEEswI0hFcV4XuLbK0cva2VwsYBzuimTdsXz8pbOGmWyqaqFwk/6vwJQeA+uM5DpEQ2OrEKkk4PSHJiq4h8jJ1xFHPSCL/wD6pG0UjbfGJPCjwg9j82JhJ644realAK6ejceqK27/EJBhBX99OGfPpwgNGNfNmGk3GZbXABIHjjxTlM9p3oAGxpifWKcbJc7ge/Jb2fWC06XL0m6lYgxlsLa3WgYKBkjGQTy5HVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Sun, 26 Feb 2023 00:29:58 +0200
Message-ID: <20230225223001.430522-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C980:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: edae97f4-0ed1-455b-3074-08db177fe2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B6Gyl7lWjOgyRO7I2FUaRQCc+AmR1n9DTrflADoQjqxLnSBg8ZgSRl+eFPkISdVhAMomoGloB1yBtzqw3z/vZeAI7pcKOWaJ/yUvu7lhOtsfJ9MkrwcPLEl83AUj69H4bt7XUpaEnwIyE6AfAG+0bODQD99Viu/s9V6mYyxxereGfbLaXjM+R0Wg11bC2caeOHLNzMYRLIhuX+YXah4VXu5LO0AWwrclyHe2C1k73Qvj+mHY5iHt1J1eusW13Vv1w4uGMPZHjxdiJ82zV9quNv7nLw1tl2vcsjn3tJTpRXfLdZJ35XlOcihrgMIbj0F/v/wKw0foYjMV26qgMGYIWZYFTH4MknFJ5bgQP1Z+k7oLL0Tg+sBnJNHeXtPzDZeUthnkrPGzeZeN1Cc2N9KTsC9lhl0UsIJXWrTUwJnGddltQjV+BQ4FVMgrqQ5W1DObTEcAN8kutZTWp35BFKknMjdNvJ4GUn7k6gi05JxTkPvdAtyDWVNjVCxKeSDR8S9Yf/G05EDbN37wYPdoK8Fliaau6iBvCjE85g/nj+7LwSDTeIS4cLdO1DsMb0+kOuxo4kz542Q/diuvMx6eJWUEwwZZ8zsXolPaWh47Rq6B8T60WFSvTLnKj0zKpMme5K+GjAJjoQ831qsxPDarAX21MgB52+znH71JUOXqXTp+L9cl4X3/EPUkhBbmjYeWFYn9ccpoo7li8fpC6aLGc3Qv/c1l5x/pNEDjGiBWLQs4QrILLlhNmALZK6DSJj0r6Ubnk2xb099u8a5ORsd2btlYLuucwRQPIGk/8OICnl2wJPg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199018)(46966006)(40470700004)(36840700001)(110136005)(316002)(966005)(36756003)(82310400005)(86362001)(54906003)(16526019)(40460700003)(186003)(2906002)(36860700001)(5660300002)(4326008)(8936002)(70586007)(8676002)(70206006)(41300700001)(1076003)(426003)(478600001)(107886003)(2616005)(26005)(6666004)(47076005)(336012)(40480700001)(7636003)(356005)(82740400003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 22:30:23.2659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edae97f4-0ed1-455b-3074-08db177fe2a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C980.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149
Subject: [virtio-dev] [PATCH 0/3] Cleanup for PCI transitional common cfg
Message-ID: <20230225222958.fd4Ep9wdcDjGPEopfoGIv2EY5lTXOY3t1cM7LeCZeC8@z>

Legacy interface PCI Device layout description has following issues.

1. repeated 'structure' word
2. virtio header was defined the 0.9.5 spec. It is referred with
   different keywards in this section with multiple different words
   as (a) virtio header, (b) general headers, (c) legacy configuration
   structure, (d) virtio common configuration structure and
   (e) other fields.
3. Driver and device requirements listing is intermixed.
4. spelling error of structure
5. Legacy interface common configuration requirements are not adjacent
   to 1.x comm

Hence, this short series overcomes above issues.

Patch summary:
patch-1 overcomes above 1 to 4 issues
patch-2 splits feature bit operations from config layout
patch-3 relocate requirements adjacent to 1.x requirements

This series is in top of [1], [2] and [3].

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/164
Please review.

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00578.html
[2] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00585.html
[3] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00597.html

Parav Pandit (3):
  transport-pci: Improve PCI legacy device layout description
  transport-pci: Split notes of PCI Device Layout
  transport-pci: Relocate common config legacy interface

 conformance.tex   |   3 +-
 transport-pci.tex | 182 +++++++++++++++++++++++++---------------------
 2 files changed, 102 insertions(+), 83 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

