Return-Path: <virtio-dev-return-13981-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC08CE7AFE
	for <virtio-dev@archiver.kernel.org>; Thu, 28 Sep 2023 06:13:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id ADA022A880
	for <virtio-dev@archiver.kernel.org>; Thu, 28 Sep 2023 06:13:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9350E98669B
	for <virtio-dev@archiver.kernel.org>; Thu, 28 Sep 2023 06:13:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 80ED9983DE1; Thu, 28 Sep 2023 06:13:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6CF43986381;
	Thu, 28 Sep 2023 06:13:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvypQkXLr3HznWkQr8xaY/sqR66UvEm/hi+GnzSYnMahDfASyomF3YwHEEit36cVNH4fFidFxRxseoUH88Vivf5Elr7uT3OF0A6AIcVbldrt3SbKv0ENFZV5V3jUk4NVZwfd8ncAlDFsqXPf8cwkYrerJmT8U4pU5b1fc9SbaW36v05DAE/UdMLjD444NthU1LGF/h2FflN1OFiFf5bgvnf9ML3Cfiri09wSKa45gr3La0FbmRHyrwsU5GzGq4e27sAvS/Z5E40OlEMKCYDSbonPckK8PszR9/SQ5jRpTXK6uVnHJJ2OBdH8li2Ozo2AD6McuSTpHplj/9h4z+AgQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKwKC6d1F8lhbbcOONVx86C+NUUSFdnaZTzl9ghuZtU=;
 b=MAfysg0EJlBYAACAqnV0R8+e6SnRiA1I1BSvSmuG6V1kT8vaSSDcTazKWw9183hBAK0vRK3F/z3kBZuwtSI+rr6k+w7zNcMmWXFwKvJ2x6koaf7UPkUNz43KgD//N7wOfA6Y+ZXXU7T1NZR0jlx0Z/z5pvVl0f9ZaLkJmWyQiP4GNjUx3jjwchQfvIvAg9RAbPhU+NLb+fqEHNlcmsdQjrP65ZeeaEkJFI9wCEzcZ2tmKYwxryh3bINP6MObXJ08RuD6JgEPUD3FoPnIZCQCf+DtaGUauFHTujU1D6l+nhru4rb1bLAum1aPYPkhVgiuX8hVZY6uDYuaTAZCFWQhkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.oasis-open.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
From: jeshwank <JESHWANTHKUMAR.NK@amd.com>
To: <virtio-comment@lists.oasis-open.org>
CC: jeshwank <JESHWANTHKUMAR.NK@amd.com>, <Mythri.Pandeshwarakrishna@amd.com>,
	<Devaraj.Rangasamy@amd.com>, <jeshwanthkumar.nk@amd.com>,
	<Rijo-john.Thomas@amd.com>, <Nimesh.Easow@amd.com>,
	<virtio-dev@lists.oasis-open.org>, <jens.wiklander@linaro.org>,
	<sumit.semwal@linaro.org>, <alex.bennee@linaro.org>,
	<arnd.bergmann@linaro.org>, <op-tee@lists.trustedfirmware.org>, Parav Pandit
	<parav@nvidia.com>, Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 28 Sep 2023 11:42:30 +0530
Message-ID: <cf8eee37bb9f5c2408f0ed8f4798e87b3c01f39c.1695881523.git.JESHWANTHKUMAR.NK@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c8dbb2-2394-4016-1f08-08dbbfe9f918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FLyTO5KC+WnlogMmRFKkxmlGaKZ5cHF1JMoZKzOjQF7kal2pDokl9P2bnFpEcLuTHE0sAwukn9jVG7kO6Bk3A8Km58UbI4FLyWpftTsZaQiZ9WfldmZTAeEmnCrxLWR2NkBlpRPLFNT9xcYAMki/inEM4IRX+p/UN7/EerM96wZzY5AopArvxoP18JcVNJ5SfyBC5xNK9wvRDTAknpfrj7/sp/ttiW6pIi7z//NfP7JqZjusYY2GlnUZOEpErc+qMVu0i4WMuKnWyjD6wEPJljM+Zcb9pRtTIS7CNOvEK00gVcRyAgUzBIt7pEyYX7qRpBFYx8rQTRitVFln8RxcMJP0N97nROpvqF6gq7dBwlOUcyoQlNc6JHiPKTgfx3bh+6Y74UKh7F91sKDcWGC6OmTk5OA61B03qw8bFS0rGOHY0E+DSHVHOlIFpJVlYpT7KvbXm30LdvKPoT37bhLUe3Tx+Q01mtFgnwE26ZbWFKthZ54aBt7OTcp069auVkOxRzYF4AFzdOzcYDtd2dZ7rOnh4yaqMLw5R6EFQqt/7BF/zBYuHLqfuKxobFZ7jbo9gN/KpdJ9tWl5MQr99Z1AvfVtVU1Pe5S0mtE/TYtljbcyGCFKpuFfpeKbgNy8rm0h8T0uyliEqk7YCRowQ4/GymZd7nTpnXoYnF35qg5WiAbXxiy3Yg7hlAlfuHbuIvDrcSyLedUqswt8LmPLTgYy5vS0PajLy5nD/WH27ZvRXbjBbUv9BFWaoRnNMZVxV8WFqe8EtI2EBBNVFE6eA1QkW1+P4T+3WPjtdbPYvEtllZY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(6666004)(7696005)(478600001)(16526019)(2616005)(83380400001)(426003)(336012)(81166007)(70586007)(41300700001)(36756003)(86362001)(5660300002)(8676002)(6916009)(8936002)(4326008)(316002)(54906003)(70206006)(356005)(36860700001)(47076005)(82740400003)(26005)(2906002)(40480700001)(40460700003)(43062005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 06:13:02.9512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c8dbb2-2394-4016-1f08-08dbbfe9f918
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841
Subject: [virtio-dev] [PATCH v3] virtio-tee: Reserve device ID 46 for TEE device

In a virtual environment, an application running in guest VM may want
to delegate security sensitive tasks to a Trusted Application (TA)
running within a Trusted Execution Environment (TEE). A TEE is a trusted
OS running in some secure environment, for example, TrustZone on ARM
CPUs, or a separate secure co-processor etc.

A virtual TEE device emulates a TEE within a guest VM. Such a virtual
TEE device supports multiple operations such as:

VIRTIO_TEE_CMD_OPEN_DEVICE – Open a communication channel with virtio
                             TEE device.
VIRTIO_TEE_CMD_CLOSE_DEVICE – Close communication channel with virtio
                              TEE device.
VIRTIO_TEE_CMD_GET_VERSION – Get version of virtio TEE.
VIRTIO_TEE_CMD_OPEN_SESSION – Open a session to communicate with
                              trusted application running in TEE.
VIRTIO_TEE_CMD_CLOSE_SESSION – Close a session to end communication
                               with trusted application running in TEE.
VIRTIO_TEE_CMD_INVOKE_FUNC – Invoke a command or function in trusted
                             application running in TEE.
VIRTIO_TEE_CMD_CANCEL_REQ – Cancel an ongoing command within TEE.
VIRTIO_TEE_CMD_REGISTER_MEM - Register shared memory with TEE.
VIRTIO_TEE_CMD_UNREGISTER_MEM - Unregister shared memory from TEE.

We would like to reserve device ID 46 for Virtio-TEE device.

Signed-off-by: Jeshwanth Kumar <jeshwanthkumar.nk@amd.com>
Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Acked-by: Sumit Garg <sumit.garg@linaro.org>
---
 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index 0a62dce..644aa4a 100644
--- a/content.tex
+++ b/content.tex
@@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
 \hline
 45         &   SPI master \\
 \hline
+46         &   TEE device \\
+\hline
 \end{tabular}
 
 Some of the devices above are unspecified by this document,
-- 
2.25.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

